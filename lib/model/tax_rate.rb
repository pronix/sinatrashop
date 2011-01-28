class TaxRate < ActiveRecord::Base
  validates_presence_of :state_id
  validates_presence_of :rate
  has_many :orders
end
