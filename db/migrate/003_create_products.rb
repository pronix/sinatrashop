require 'lib/model/product'

class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name, :null => false
      t.decimal :price, :null => false #, :precision => 8, :scale => 2
      t.string :description, :null => false
    end

    Product.create({ :id => 1,
      :name => "Blackberry Delight",
      :price => 3.00, :description => "This vanilla cupcake is topped with light whipped vanilla frosting and fresh blackberry drizzle." })
    Product.create({ :id => 2,
      :name => "Chocolate Strawberry",
      :price => 2.50,
      :description => "Splurge on this scrumptious chocolate strawberry treat, with rich dark chocolate topped with strawberry whipped cream frosting." })
    Product.create({ :id => 3,
      :name => "Smores",
      :price => 3.50,
      :description => "This fresh milk chocolatey cake is layered with marshmalley goodness crisped to perfection." })
  end

  def self.down
    drop_table :products
  end
end
