require "delayed_job"
require "delayed/backend/active_record"
class Delayed::Backend::ActiveRecord::Job
  def self.db_time_now
    if ::ActiveRecord::Base.default_timezone == :utc
      Time.now.utc
    else
      Time.now
    end
  end

  def invoke_job_with_transaction
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.pooled do
        ActiveRecord::Base.cache do
          invoke_job_without_transaction
        end
      end
    end
  end

  alias_method_chain :invoke_job, :transaction
end