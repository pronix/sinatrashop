require 'digest/sha1'
  
module Sinatra
  module Authorization
    module Helpers
      def authorized?
        !session["username"].nil?
      end
     
      def admin?
        authorized?
      end
      def require_administrative_privileges
        authorized?
      end
    end

    def self.registered(app)
      app.helpers Authorization::Helpers

      app.get '/login' do
        redirect '/' if authorized?
        erb :login
      end

      app.post '/login.json' do
        user = User.login(json_to_hash(request.body.read.to_s))
        if user.nil?
          status 500
        else
          session["username"] = user.username
          status 200
          user.username.to_json 
        end
      end

      app.get '/logout' do
        session["username"] = nil
        redirect '/'
      end

      app.post '/logout.json' do
        session["username"] = nil
        status 200
      end

      app.post '/create_account.json' do
        input = json_to_hash(request.body.read.to_s)
        if input[:password] != input[:repassword]
          status 500
          "Your passwords do not match.".to_json
        elsif input[:password] == ''
          status 500
          "Your password must not be blank.".to_json
        else
          user = User.create_account(input)
          if user.errors.empty?
            session["username"] = user.username
            status 200
            user.username.to_json
          else
            status 500
            user.errors.full_messages.to_json
          end
        end
      end

      app.get '/account' do
        redirect '/' if !authorized?
        @user = User.find_by_username(session["username"])
        erb :account
      end
    end
  end
end
