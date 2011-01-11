require 'sinatra'
require 'erb'
require 'active_record'
require 'models/order'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'db/development.sqlite3.db'
)

get '/' do
  erb :index, :locals => { :test => '' }
end

post '/' do
  order = Order.new(params)
  puts "#{order.inspect}"
  response = ''
  if order.save
    puts "saved."
    if order.process
      #success
    else
      #unable to process
    end
  else
    response = order.errors.full_messages.join(' ') 
  end
  erb :index, :locals => { :response => response }
end

#get '/admin' do
#  'Hello admin'
#end
