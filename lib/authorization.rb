require 'digest/sha1'

module Store 
  module Authorization
    def auth
      @auth ||= Rack::Auth::Basic::Request.new(request.env)
    end
   
    def unauthorized!
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw :halt, [ 401, 'Authorization Required' ]
    end
   
    def bad_request!
      throw :halt, [ 400, 'Bad Request' ]
    end
   
    def authorized?
      request.env['REMOTE_USER']
    end
   
    def authorize(username, password)
      @authorized_user ||= User.where(:username => username, :password => Digest::SHA1.hexdigest(password)).first
      !@authorized_user.nil?
    end
   
    def require_administrative_privileges
      return if authorized?
      unauthorized! unless auth.provided?
      bad_request! unless auth.basic?
      unauthorized! unless authorize(*auth.credentials)
      request.env['REMOTE_USER'] = auth.username
    end
   
    def admin?
      authorized?
    end
  end
end
