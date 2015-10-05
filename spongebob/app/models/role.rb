class Role < ActiveRecord::Base
  serialize :permissions, Array
  has_many :user_roles,-> {where("status='active'")} , class_name: 'UserRoles'

  def users
  	self.user_roles.map{|u| User.find(u.user_id)}.select{|u| u.status=="active"}
  end
end