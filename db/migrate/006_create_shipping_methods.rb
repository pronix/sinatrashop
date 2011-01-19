class CreateShippingMethods < ActiveRecord::Migration
  def self.up
    create_table :shipping_methods do |t|
      t.string :klass, :null => false
      t.string :detail
    end
  end

  def self.down
    drop_table :shipping_methods
  end
end
