class Calculator::PerItem < Calculator
  def self.description
    "Per Item"
  end

  def self.available?(params)
    true
  end

  def self.compute(shipping_method, params=nil)
    cart = Cart.new(params[:cart])
    cart.items.collect { |i| i[:quantity] }.sum*(shipping_method.detail).to_f 
  end
end
