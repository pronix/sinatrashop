require 'sinatra/base'

module Sinatra  
  module Admin
    module Helpers
      def json_to_hash(body=nil)
        symbolize(JSON.parse(body))
      end
    
      def symbolize(hash)
        hash.inject({}) {|h, keyval| h[keyval[0].to_sym] = keyval[1]; h}
      end
    end
  
    def self.registered(app)
      app.helpers Admin::Helpers

      app.get '/admin' do
        require_administrative_privileges
        @files = Dir[File.join(File.dirname(__FILE__), '../public/javascripts/admin', '*.js')].collect { |b| b.basename }
        erb :admin
      end
    
      app.get '/admin/:type' do |type|
        require_administrative_privileges
        content_type :json
        begin
          klass = type.camelize.constantize
          objects = klass.all
          status 200
          objects.to_json
        rescue Exception => e
          halt 500, [e.message].to_json 
        end
      end
    
      app.delete '/admin/:type/:id' do |type, id|
        require_administrative_privileges
        content_type :json
        klass = type.camelize.constantize
        instance = klass.find(id)
        begin
          if instance.destroy
            status 200
            "success".to_json
          else
            status 400
            errors = instance.errors.full_messages
            [errors.first].to_json
          end
        rescue Exception => e
          halt 500, [e.message].to_json
        end
      end
    
      # Create a new admin thing (default)
      app.post '/admin/:type/new' do |type|
        require_administrative_privileges
        content_type :json
        input = json_to_hash(request.body.read.to_s)
    
        klass = type.camelize.constantize
        instance = klass.new(input)
        begin
          if instance.save
            # success!
            status 200
            instance.to_json
          else
            status 400
            errors = instance.errors.full_messages
            [errors.first].to_json
          end
        rescue Exception => e
          halt 500, [e.message].to_json
        end
      end
    
      # Update admin thing
      app.post '/admin/:type/:id' do |type, id|
        require_administrative_privileges
        content_type :json
        input = json_to_hash(request.body.read.to_s)
    
        klass = type.camelize.constantize
        instance = klass.find(id)
        begin
          if instance.update_attributes(input)
            # success!
            status 200
     	    instance.to_json
          else
            status 400
            errors = instance.errors.full_messages
            [errors.first].to_json
          end
        rescue Exception => e
          halt 500, [e.message].to_json
        end
      end
    end
  end
end
