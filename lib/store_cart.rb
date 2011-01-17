require 'sinatra/base'

module Sinatra  
  module StoreCart
    module Helpers
      def get_cart
        session[:cart] ||= Cart.new
        session[:cart]
      end

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

      app.set :sessions, true

      app.get '/cart' do
        @cart = get_cart
        erb :cart, :locals => { :params => { :order => {}, :credit_card => {} }}
      end

      app.post '/cart/add' do
        get_cart.add(params)
        redirect "/cart"
      end

      app.post '/cart/update' do
        get_cart.update(params)
        redirect "/cart"
      end

      #perhaps change this to post later?
      app.get '/cart/remove/:product_id' do |product_id|
        get_cart.remove(product_id)
        redirect "/cart"
      end
      
      app.get '/cart/clear' do
        get_cart.clear
        redirect "/cart"
      end
    end
  end
end
