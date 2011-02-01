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
      app.get '/create_account' do
        redirect '/' if authorized?
        erb :login
      end

      app.post '/login' do
        authorized_user = User.where(:username => params[:email], :password => Digest::SHA1.hexdigest(params[:password])).first
        request.env['REMOTE_USER'] = authorized_user.username if authorized_user

        if authorized?
          #success message
          redirect '/'
        else
          #fail message
          @login_errors = 'Incorrect username or password.'
        end
        erb :login
      end
 
      app.get '/logout' do
        request.env['REMOTE_USER'] = nil
        redirect '/'
       end

      app.post '/create_account' do
        begin
	  if params[:password] != params[:repassword]
            raise Exception, 'Your passwords did not match.'
          end
          if params[:password].length < 6
            raise Exception, 'Your password must be at least 6 characters.'
          end
          user = User.create({ :username => params[:email],
            :password => Digest::SHA1.hexdigest(params[:password]) })
          if user.save 
            request.env['REMOTE_USER'] = user.username
            redirect '/'
          else
            raise Exception, user.errors.full_messages
          end
        rescue Exception => e
          @create_errors = e.message
        end
        erb :login
      end

      app.get '/orders' do
        # redirect if not logged in
        # list users orders
      end
    end
  end
end
