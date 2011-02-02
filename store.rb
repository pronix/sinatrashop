require 'sinatra/base'
require 'sinatra/reloader'
require 'erb'
require 'active_record'

class Store < Sinatra::Base
  instance_eval do
    def load_dependencies!
      unless @dep_loaded
        Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each do |file|
          require file
        end
        @dep_loaded = true
      end
    end

    def load_models!
      unless @loaded
        #Combine the following later
        Dir[File.join(File.dirname(__FILE__), 'lib', 'model', '*.rb')].each do |file|
          require file
        end
        Dir[File.join(File.dirname(__FILE__), 'lib', 'model', '*', '*.rb')].each do |file|
          require file
        end
        @loaded = true
      end
    end 

    load_dependencies!
    load_models!
  end

  register Sinatra::Admin
  register Sinatra::Authorization
  register Sinatra::Configuration
  register Sinatra::ShoppingCart
  register Sinatra::Pages
  register Sinatra::Shipping
  register Sinatra::Tax
  configure(:development) do
    register Sinatra::Reloader
    also_reload "lib/model/*.rb"
  end

  before do
    @title = settings.store_title
  end
  
  enable :sessions
  get '/' do
    @products = Product.all
    erb :index, :locals => { :params => { :credit_card => {}, :order => {} } }
  end
    
  run! if app_file == $0
end
