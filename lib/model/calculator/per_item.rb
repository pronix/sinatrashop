class Calculator::PerItem < Calculator
  def self.description
    "Per Item"
  end

  def self.available?(params)
    true
  end

  def self.compute(shipping_method, cart, params=nil)
    cart.items.collect { |i| i[:quantity] }.sum*(shipping_method.detail).to_f 
  end
end
