require 'store'
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'development'

class StoreTests < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_homepage_get_is_ok
    get '/'
    assert last_response.ok?
  end

  def test_invalid_order_entry
    post '/', { :order => { :bill_firstname => 'Steph',
      :bill_lastname => 'Skardal',
      :bill_address1 => '12360 Carolina Dr.',
      :bill_city => 'Lakewood',
      :bill_state => 'CO',
      :bill_zipcode => 80228,
      :email => 'steph',
      :phone => '6304844834'
    } }
    assert last_response.body.include?("Ship firstname can't be blank")
    assert last_response.body.include?("Ship lastname can't be blank")
    assert last_response.body.include?("Ship address1 can't be blank")
    assert last_response.body.include?("Ship city can't be blank")
    assert last_response.body.include?("Ship state can't be blank")
    assert last_response.body.include?("Ship zipcode can't be blank")
    assert last_response.body.include?("Email is invalid")
  end

  def test_invalid_credit_card
    post '/', { :credit_card => {
      :number => "411111111111" },
      :order => { 
        :bill_firstname => 'Steph',
        :bill_lastname => 'Skardal',
        :bill_address1 => '12360 Carolina Dr.',
        :bill_city => 'Lakewood',
        :bill_state => 'CO',
        :bill_zipcode => 80228,
        :ship_firstname => 'Steph',
        :ship_lastname => 'Skardal',
        :ship_address1 => '12360 Carolina Dr.',
        :ship_city => 'Lakewood',
        :ship_state => 'CO',
        :ship_zipcode => 80228,
        :email => 'steph@store.com',
        :phone => '6304844834',
      }
    }
    assert last_response.body.include?("Your credit card was not valid.")
  end

  def test_successful_transaction
    post '/', { :credit_card => {
        :number => "4111111111111111",
        :verification_value => "123",
        :month => "01",
        :year => "2011"
      },
      :order => { 
        :bill_firstname => 'Stephanie',
        :bill_lastname => 'Skardal',
        :bill_address1 => '12360 Carolina Dr.',
        :bill_city => 'Lakewood',
        :bill_state => 'CO',
        :bill_zipcode => 80228,
        :ship_firstname => 'Stephanie',
        :ship_lastname => 'Skardal',
        :ship_address1 => '12360 Carolina Dr.',
        :ship_city => 'Lakewood',
        :ship_state => 'CO',
        :ship_zipcode => 80228,
        :email => 'steph@store.com',
        :phone => '6304844834',
      }
    }
    assert last_response.body.include?("success.png")
  end
end
