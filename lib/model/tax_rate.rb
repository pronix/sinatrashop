class TaxRate < ActiveRecord::Base
  validates_presence_of :state_id
  validates_uniqueness_of :state_id
  validates_presence_of :rate

  belongs_to :state
  has_many :orders
end
