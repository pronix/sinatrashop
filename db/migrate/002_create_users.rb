require 'digest/sha1'
require 'lib/model/user'

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :null => false, :limit => 40
      t.string :password, :null => false, :limit => 40
    end
 
    User.create({ :username => "steph@endpoint.com",
      :password => Digest::SHA1.hexdigest("password") })
  end

  def self.down
    drop_table :users
  end
end
