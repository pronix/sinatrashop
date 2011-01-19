require 'sinatra/base'

module Sinatra  
  module Shipping
    module Helpers
    end
  
    def self.registered(app)
      app.helpers Shipping::Helpers

      app.post '/shipping_methods' do
        input = json_to_hash(request.body.read.to_s)
        shipping_methods = ShippingMethod.all
        @available_methods = []  
        shipping_methods.each do |shipping_method|
          klass = shipping_method.klass.camelize.constantize
          if klass.available?(params)
            @available_methods << {
              :name	=> klass.description,
              :amount	=> price_display(klass.compute(shipping_method, input)),
              :id	=> shipping_method.id
            }
          end
        end
        @available_methods.to_json
      end
    end
  end
end
