class CreateTableLocation < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
    	t.string :type
    	t.string :zip, :limit => 10
    	t.string :city, :limit => 200
    	t.string :district, :limit => 100
    	t.string :state, :limit => 100
    	t.string :country, :limit => 50
    	t.string :status, :default=> 'active'
    	t.string :phone_code
    	t.string :iso2code
    	t.string :iso3code
    	t.string :created_by
    	t.string :last_updated_by
    end
    execute "ALTER TABLE `locations` ADD COLUMN `created_at` timestamp NULL DEFAULT NULL, ADD COLUMN `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
    add_index(:locations,:type,:name=>"index_type")
    add_index(:locations,:zip,:name=>"index_zip")
    add_index(:locations,:city,:name=>"index_city")
    add_index(:locations,:state,:name=>"index_state")
    add_index(:locations,:country,:name=>"index_country")
    add_index(:locations,[:country,:state,:district,:city,:zip],:name=>"c_st_dis_ci_zip")
    add_index(:locations,[:country,:state,:city,:zip],:name=>"c_st_ci_zip")
  end

  def self.down
  	drop_table :locations
  end
end
