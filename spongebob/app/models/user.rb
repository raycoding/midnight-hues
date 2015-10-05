class User < ActiveRecord::Base
	validates_presence_of :name , :message => "Name cannot be blank"
	validates_presence_of :email , :message => "Email cannot be blank"
  validates_uniqueness_of :email , :message => "Email is already registered"
	validates_presence_of :primary_phone , :message => "Mobile Number cannot be blank"
  validates_uniqueness_of :primary_phone , :message => "Mobile Number is already registered"
  acts_as_authentic do |c|
  	c.login_field = :primary_phone
    c.validate_login_field = false
  	c.crypto_provider = Authlogic::CryptoProviders::SCrypt
  end

  scope :active, -> {where("status='active'")}
  scope :allactive, -> {where("status='active' or status='reverify'")}

  before_save :set_roles
  has_many :user_roles, class_name: 'UserRoles'
  has_many :roles,-> {where("user_roles.status='active'")} , :through => :user_roles
  accepts_nested_attributes_for :user_roles

  def set_username
		self.username = self.email
	end

	attr_accessor :roles_changed

	def permissions
    roles.map(&:permissions).flatten(1)
  end

  def grantable_roles
    Role.where(:id=>(self.user_roles.active.where(:grant_option=>true).map(&:role_id)))
  end

  def manager
    User.find_by_id(self.manager_id)
  end

  def roles_ids
    user_roles.active.map(&:role_id)
  end

  def roles_names
    roles.map(&:name)
  end

  def roles
    Role.where(:id=>user_roles.active.map(&:role_id))
  end

  def grantable_roles_ids=(values)
    values||=[]
    values = values.each.map{|h| h.to_i}
    values = values - (values - roles_ids)
    user_roles.each do |ur|
      if values.include?(ur.role_id)
        ur.update_attribute(:grant_option,true)
      else
        ur.update_attribute(:grant_option,false)
      end
    end
  end

  def roles_ids=(values)
    values||=[]
    values = values.each.map{|h| h.to_i}
    assignable_ids = Role.all.map(&:id)
    values= values - (values - assignable_ids)

    old_role_ids= roles_ids

    (old_role_ids-values).each do |role_id|
      ur=self.user_roles.select{|b| b.role_id == role_id}.first
      ur.status='disable'
      ur.grant_option=false
      ur.updated_by = User.current_user.id if User.current_user
      self.roles_changed = true
    end

    values.each do |role_id|
      if(x=self.user_roles.select{|b| b.role_id == role_id}).blank?
        ba=self.user_roles.build(:role_id=>role_id,:status=>'active',:created_by=>User.current_user.id,:grant_option=>false)
        self.roles_changed = true
      else
        x.each do |ur|
          next if ur.status=='active'
          ur.status='active'
          ur.grant_option=false
          ur.updated_by = User.current_user.id if User.current_user
          self.roles_changed = true if ur.changes.any?
        end
      end
    end
  end

  def reset_login_token!
    self.login_token=Authlogic::Random.friendly_token
    self.save
  end

  def set_roles
    self.roles_ids=[] if !['active','reverify'].include?(self.status) || self.manager_id_changed?
  end
end