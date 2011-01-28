class State < ActiveRecord::Base
  validates_presence_of :abbr
  validates_presence_of :name

  has_one :tax_rate
end
