class Calculator::FlatRate < Calculator
  def self.description
    "Flat Rate"
  end

  def self.available?(params)
    true
  end

  def self.compute(shipping_method, object=nil)
    shipping_method.detail.to_f
  end
end
