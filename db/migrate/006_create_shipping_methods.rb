require 'lib/model/shipping_method'

class CreateShippingMethods < ActiveRecord::Migration
  def self.up
    create_table :shipping_methods do |t|
      t.string :klass, :null => false
      t.string :detail
    end

    #ShippingMethod.create({ :klass => 'Calculator::FlatRate', :detail => "4.00" })
  end

  def self.down
    drop_table :shipping_methods
  end
end
