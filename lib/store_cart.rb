require 'sinatra/base'

module Sinatra  
  module StoreCart
    module Helpers
      def price_display(price)
        d = price.to_f.to_s.split('.')
        dec = d[1]
        if d[1].to_i < 1
          dec = "00"
        elsif d[1].to_i < 10
          dec = d[1] + "0"
        elsif d[1].to_i > 99
          dec = (d[1][0..2].to_f/100).round.to_s
        end
        "$" + d[0] + "." + dec
      end
    end
  
    def self.registered(app)
      app.helpers StoreCart::Helpers

      app.get '/cart' do
        @cart = Cart.build_cart(request.cookies["cart"])
        @total = @cart.sum { |item| item[:quantity]*item[:product].price }
        erb :cart, :locals => { :params => { :order => {}, :credit_card => {} }}
      end

      app.post '/cart/add' do
        response.set_cookie("cart", Cart.add(request.cookies["cart"], params))
        redirect "/cart"
      end

      app.post '/cart/update' do
        response.set_cookie("cart", Cart.update(request.cookies["cart"], params))
        redirect "/cart"
      end

      app.get '/cart/remove/:product_id' do |product_id|
        response.set_cookie("cart", Cart.remove(request.cookies["cart"], product_id))
        redirect "/cart"
      end
      
      app.get '/cart/clear' do
        response.set_cookie("cart", Cart.clear)
        redirect "/cart"
      end
    end
  end
end
