#deep_cloning support for activerecord objects
require 'deep_cloning'
ActiveRecord::Base.send(:include, DeepCloning)

#pooling support for activerecord objects
require 'pooling'
ActiveRecord::Base.send(:include, Pooling)

#LatLongFinder
require 'lat_long_finder'

#Delayed Job in Transaction
require 'delayed_job_with_transaction'

require File.join(Rails.root,"config/initializers","hash_struct.rb")
require 'digest/md5'
CONFIG = HashStruct.new(YAML::load_file(File.join(Rails.root,"config","app_config.yml"))[Rails.env])

class ActiveRecord::Base
  cattr_accessor :current_user
end

def sid(current_user_email='shuddhashil.ray@infibeam.net')
	ActiveRecord::Base.connection.instance_variable_set :@logger, Logger.new(STDOUT)
  require 'hirb'
  Hirb.enable
  # if !current_user_email.blank?
  # 	User.current_user = User.find_by_email(current_user_email)
  # end
end

def dji
	Delayed::Job.last.invoke_job
end

def djd
	Delayed::Job.destroy_all
end