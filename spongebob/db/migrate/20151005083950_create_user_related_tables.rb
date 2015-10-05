class CreateUserRelatedTables < ActiveRecord::Migration
  def self.up
  	create_table :users, :force => true do |t|
    	t.string :name, :null=> :false
      t.string :email, :null=> :false
      t.string :primary_phone, :null=> :false
      t.string :status, :null=>:false ,:default=>'active'
      t.integer :manager_id
      t.string  :password
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string    :single_access_token
			t.string    :perishable_token
			t.integer   :login_count,:default => 0
			t.integer   :failed_login_count,:default => 0
			t.datetime  :current_login_at
			t.datetime  :last_login_at
			t.string    :current_login_ip
			t.string    :last_login_ip
      t.string    :login_token
      t.timestamps
    end
    add_index :users, :email, :unique=>:true
    add_index :users, :primary_phone, :unique=>:true

    create_table "roles", :force => true do |t|
	    t.string   "name",                              :null => false
	    t.text     "permissions"
	    t.string   "status",      :default => "active"
	    t.text     "description"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  end

	  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

	  create_table "user_roles", :force => true do |t|
	    t.integer  "user_id",                                         :null => false
	    t.integer  "role_id",                                         :null => false
	    t.integer  "grant_option", :limit => 1, :default => 0,        :null => false
	    t.string   "status",                    :default => "active"
	    t.string   "created_by",                :default => "self"
	    t.string   "updated_by",                :default => "self"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  end

	  add_index "user_roles", ["user_id", "role_id"], :name => "index_user_roles_on_user_id_and_role_id", :unique => true
  end

  def self.down
  	drop_table "users"
  	drop_table "roles"
  	drop_table "user_roles"
  end
end
