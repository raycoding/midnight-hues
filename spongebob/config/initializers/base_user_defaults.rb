class ActiveRecord::Base

  def self.current_user
    @@current_user ||=nil
  end

  def self.current_user=(user)
    @@current_user = user
  end

  def self.client_blank?
    self.current_user.nil? || self.current_user['client_id'].nil?
  end
  
  def add_created_by
    if self.has_attribute? :created_by
      self.created_by ||= ActiveRecord::Base.current_user['name'] unless ActiveRecord::Base.current_user.nil?
    end
  end

  def add_updated_by
    if self.has_attribute? :updated_by
      self.updated_by = ActiveRecord::Base.current_user['name'] unless ActiveRecord::Base.current_user.nil?
    end
  end
end
