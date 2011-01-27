class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string   :email, :null => false
      t.string   :bill_firstname, :null => false
      t.string   :bill_lastname, :null => false
      t.string   :bill_address1, :null => false
      t.string   :bill_address2
      t.string   :bill_city, :null => false
      t.string   :bill_state, :null => false
      t.string   :bill_zipcode, :null => false
      t.string   :ship_firstname, :null => false
      t.string   :ship_lastname, :null => false
      t.string   :ship_address1, :null => false
      t.string   :ship_address2
      t.string   :ship_city, :null => false
      t.string   :ship_state, :null => false
      t.string   :ship_zipcode, :null => false
      t.string   :phone, :null => false
      t.decimal  :ship_cost
      t.decimal  :total
      t.references :shipping_method
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
