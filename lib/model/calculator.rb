class Calculator
  def self.compute(shipping_method, omething=nil)
    raise(NotImplementedError, "Not implemented")
  end

  def self.description
    "Base Calculator"
  end

  def self.available?(object)
    true  #overridden
  end
end
