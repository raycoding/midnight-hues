class CreateTableLaundromat < ActiveRecord::Migration
  def self.up
    create_table "laundromats" do |t|
    	t.string :name, :null=> :false
    	t.string :code, :null=> :false
    	t.string :business_phone, :null=> :false
    	t.string :alternate_business_phone
    	t.string :email
    	t.string :contact_person, :null=> :false
    	t.string :contact_person_phone, :null=> :false
    	t.boolean :has_website, :default=>0
    	t.string :website_url
    	t.string :status, :null=>:false ,:default=>'active'
    	t.boolean :has_laundry_service
    	t.boolean :has_dry_cleaning_service
    	t.boolean :cod_enabled
    	t.boolean :uses_organic_solvents
    	t.string :is_franchise, :default=>0
    	t.text :options
    end
    execute "ALTER TABLE `laundromats` ADD COLUMN `created_at` timestamp NULL DEFAULT NULL, ADD COLUMN `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
  	add_index(:laundromats,:name,:name=>"index_name",:unique=>true)
  	add_index(:laundromats,:business_phone,:name=>"index_business_phone",:unique=>true)
  	add_index(:laundromats,:email,:name=>"index_email",:unique=>true)
  	add_index(:laundromats,:uses_organic_solvents,:name=>"index_has_laundry_service")
  	add_index(:laundromats,:uses_organic_solvents,:name=>"index_has_dry_cleaning_service")
  	add_index(:laundromats,:cod_enabled,:name=>"index_cod_enabled")
  	add_index(:laundromats,:uses_organic_solvents,:name=>"index_uses_organic_solvents")
  	add_index(:laundromats,:is_franchise,:name=>"index_is_franchise")
  end

  def self.down
  	drop_table "laundromats"
  end
end
