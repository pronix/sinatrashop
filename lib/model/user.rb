class User < ActiveRecord::Base
  validates_presence_of :username
  validates_presence_of :password
  has_many :orders

  def self.login(params)
    return User.where(:username => params[:email], :password => Digest::SHA1.hexdigest(params[:password])).first
  end

  def self.create_account(params)
    user = User.new({ :username => params[:email], :password => Digest::SHA1.hexdigest(params[:password]) })
    user.save
    user
  end
end
