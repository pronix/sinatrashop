require 'sinatra'
require 'erb'
require 'active_record'
require 'configuration'
require 'models/order'

configure do
  set :public, File.dirname('/var/www/ep/shop/public')
end
  
  
get '/' do
  erb :index, :locals => { :response => '',
                           :params => { :order => {}, :credit_card => {} },
                           :success => 0 }
end
  
post '/' do
  order = Order.new(params[:order])
  response = ''
  success = 0
  if order.save
    params[:credit_card][:first_name] = params[:order][:bill_firstname]
    params[:credit_card][:last_name] = params[:order][:bill_lastname]
    credit_card = ActiveMerchant::Billing::CreditCard.new(params[:credit_card])
    if credit_card.valid?
      gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(settings.authorize_credentials)

      # Authorize for $10 dollars (1000 cents) 
      response = gateway.authorize(1000, credit_card)
      if response.success?
        order.update_attribute(:status, "complete")
        gateway.capture(1000, response.authorization)
        response = 'Success!'
        success = 1
      else
        response = response.message
      end
    else
      response = "Your credit card was not valid."
    end
  else
    response = '<ul><li>' + order.errors.full_messages.join('</li><li>') + '</li></ul>'
  end
  erb :index, :locals => { :response => response, :success => success }
end
