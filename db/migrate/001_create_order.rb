class CreateOrder < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string   "email"
      t.string   "bill_firstname"
      t.string   "bill_lastname"
      t.string   "bill_address1"
      t.string   "bill_address2"
      t.string   "bill_city"
      t.integer  "bill_state"
      t.string   "bill_zipcode"
      t.string   "ship_firstname"
      t.string   "ship_lastname"
      t.string   "ship_address1"
      t.string   "ship_address2"
      t.string   "ship_city"
      t.integer  "ship_state"
      t.string   "ship_zipcode"
      t.string   "phone"
      t.string   "status", :default => "pending"
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end

  
