module Pooling

  def self.included(base)
    base.alias_method_chain :reload, :unpooled
    base.class_eval do
      private
      extend Pool
        def create_or_update_with_pooled
          out = create_or_update_without_pooled
          if ActiveRecord::Base.obj_pool_enabled
            ActiveRecord::Base.obj_pool[self.cache_key] = self
          end
          out
        end
        alias_method_chain :create_or_update , :pooled
      class << self

        def instantiate_with_pooled(record,column_type={})
          if ActiveRecord::Base.obj_pool_enabled
            #check in the pool
            obj=instantiate_without_pooled(record,column_type)
            if obj.send(obj.class.primary_key).nil?
              obj
            else
              ActiveRecord::Base.obj_pool[obj.cache_key] ||= obj
              ActiveRecord::Base.obj_pool[obj.cache_key]
            end
          else
            instantiate_without_pooled(record)
          end
        end
        alias_method_chain :instantiate , :pooled
      end
    end
  end

  def reload_with_unpooled
    ActiveRecord::Base.unpooled do
      reload_without_unpooled
    end
  end
  
  module Pool
    attr_accessor :obj_pool, :obj_pool_enabled

    def pooled
      old, ActiveRecord::Base.obj_pool_enabled = ActiveRecord::Base.obj_pool_enabled, true
      ActiveRecord::Base.obj_pool ||= {}
      yield
    ensure
      ActiveRecord::Base.obj_pool_enabled = old
      ActiveRecord::Base.obj_pool.clear if ActiveRecord::Base.obj_pool
    end

    def unpooled
      old, ActiveRecord::Base.obj_pool_enabled = ActiveRecord::Base.obj_pool_enabled, false
      yield
    ensure
      ActiveRecord::Base.obj_pool_enabled = old
    end
  end

end
