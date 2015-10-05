class UserRoles < ActiveRecord::Base
  self.table_name = "user_roles"
  belongs_to    :user
  belongs_to    :role
  scope :active, -> {where("status='active'")}
end