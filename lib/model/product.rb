class Product < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :price
  validates_numericality_of :price
  validates_presence_of :description

  has_many :orders
end
