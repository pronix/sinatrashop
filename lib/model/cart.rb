class Cart
  attr_accessor :items

  def initialize
    self.items = []
  end

  def add(params)
    cart_item = self.items.detect { |item| item.product.id == params[:product_id].to_i }
    if cart_item
      cart_item.quantity += params[:quantity].to_i
    else
      self.items << CartItem.new(params)
    end
  end

  def remove(product_id)
    self.items = self.items.select { |item| item.product.id != product_id.to_i }
  end

  def update(params)
    self.items.each { |item| item.quantity = params[:quantity][item.product.id.to_s].to_i }
    self.items = self.items.select { |item| item.quantity > 0 }
  end

  def clear
    self.items = []
  end

  def total
    self.items.collect { |item| item.product.price*item.quantity }.sum
  end
end
