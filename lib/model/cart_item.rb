class CartItem
  attr_accessor :product
  attr_accessor :quantity

  def initialize(params)
    #check here for quantity is non zero?
    self.product = Product.find(params[:product_id].to_i)
    self.quantity = params[:quantity].to_i
  end
end
