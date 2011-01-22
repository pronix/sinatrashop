class Product < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :price
  validates_numericality_of :price
  validates_presence_of :description

  has_many :orders

  def price_display
     d = price.to_f.to_s.split('.')
     dec = d[1]
     if d[1].to_i < 1
       dec = "00"
     elsif d[1].to_i < 10
       dec = d[1] + "0"
     elsif d[1].to_i > 99
       dec = (d[1][0..2].to_f/100).round.to_s
     end
     "$" + d[0] + "." + dec
  end

  def image
    "/images/" + name.downcase.gsub(' ', '_') + ".jpg"
  end
end
