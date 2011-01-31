require 'digest/sha1'
  
module Sinatra
  module Authorization
    module Helpers
      def authorized?
        request.env['REMOTE_USER']
      end
     
      def authorize(username, password)
        @authorized_user ||= User.where(:username => username, :password => Digest::SHA1.hexdigest(password)).first
        !@authorized_user.nil?
      end
     
      def admin?
        authorized?
        # update to roles here
      end
    end

    def self.registered(app)
      app.helpers Authorization::Helpers

      app.get '/login' do
        redirect '/' if authorized?
        erb :login
      end

      app.post '/login' do
        @authorized_user = User.where(:username => params[:email], :password => Digest::SHA1.hexdigest(params[:password])).first
        request.env['REMOTE_USER'] = @authorized_user.username if @authorized_user

        if authorized?
          #success message
          redirect '/'
        else
          #fail message
          redirect '/login'
        end
      end
 
      app.get '/logout' do
        request.env['REMOTE_USER'] = nil
        redirect '/'
       end

      app.post '/create_account' do
        # create user, set to removeuser
        # request.env...
        redirect '/'
      end

      app.get '/orders' do
        # redirect if not logged in
        # list users orders
      end
    end
  end
end
