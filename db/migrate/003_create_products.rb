require 'lib/model/product'

class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name, :null => false
      t.decimal :price, :null => false #, :precision => 8, :scale => 2
      t.string :description, :null => false
    end

    Product.create({ :id => 1, :name => "Awesome Book", :price => 10.00, :description => "This book is awesome." })
    Product.create({ :id => 2, :name => "Rad Book", :price => 15.50, :description => "This book is rad." })
    Product.create({ :id => 3, :name => "Excellent Book", :price => 20.00, :description => "This book is excellent." })
  end

  def self.down
    drop_table :products
  end
end
