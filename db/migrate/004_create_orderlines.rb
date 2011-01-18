class CreateOrderlines < ActiveRecord::Migration
  def self.up
    create_table :orderlines do |t|
      t.references :order
      t.references :product
      t.integer :quantity
      t.decimal :price
    end

    # add database constraints here on order and products table
  end

  def self.down
    drop_table :orderlines
  end
end

  
