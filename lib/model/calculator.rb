class Calculator
  def self.compute(shipping_method, cart, params=nil)
    raise(NotImplementedError, "Not implemented")
  end

  def self.description
    "Base Calculator"
  end

  def self.available?(object)
    true  #overridden
  end
end
