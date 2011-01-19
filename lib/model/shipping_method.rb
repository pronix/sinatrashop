class ShippingMethod < ActiveRecord::Base
  validates_presence_of :klass
  has_many :orders

  # deprecation here - update
  def validate
    klass = self.klass.camelize.constantize
    if !defined?(klass)
      errors.add :klass, "This calculator does not exist."
    end
  end

  def all_available
    #replace based on availability later
    ShippingMethod.all
  end
end
