class Order < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :bill_firstname
  validates_presence_of :bill_lastname
  validates_presence_of :bill_address1
  validates_presence_of :bill_city
  validates_presence_of :bill_state
  validates_presence_of :bill_zipcode
  validates_presence_of :ship_firstname
  validates_presence_of :ship_lastname
  validates_presence_of :ship_address1
  validates_presence_of :ship_city
  validates_presence_of :ship_state
  validates_presence_of :ship_zipcode
  validates_presence_of :phone
  validates_presence_of :shipping_method_id
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  belongs_to :shipping_method
  has_many :orderlines

  def avs_address
    {
      :address => bill_address1,
      :city    => bill_city,
      :state   => bill_state,
      :zip     => bill_zipcode,
      :country => "US"
    }
  end

  def update_totals(cart)
    klass = shipping_method.klass.camelize.constantize
    input = {
      :order => {
        :ship_state => ship_state,
        :ship_country => "US"
      }
    }
    self.ship_cost = klass.compute(shipping_method, cart, input) 
    self.total = cart.total + self.ship_cost
    save
  end
end
