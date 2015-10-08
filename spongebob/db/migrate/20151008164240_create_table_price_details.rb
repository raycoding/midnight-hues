class CreateTablePriceDetails < ActiveRecord::Migration
  def self.up
    create_table :price_details do |t|
    	t.string :category
    	t.string :item, :limit => 255
    	t.decimal :price, :precision => 10, :scale => 3
      t.timestamps
    end
  end

  def self.down
  	drop_table :price_details
  end
end
