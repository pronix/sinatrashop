class Calculator::FlatPercent < Calculator
  def self.description
    "Flat Percent"
  end

  def self.available?(params)
    true
  end

  def self.compute(shipping_method, params=nil)
    cart = Cart.new(params[:cart])
    cart.total*(shipping_method.detail).to_f 
  end
end
