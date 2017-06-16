require 'sinatra/base'
require 'pp'

require_relative 'ruby_gestpay_starter/constants'
require_relative 'ruby_gestpay_starter/version'
require_relative 'ruby_gestpay_starter/gestpay_ws_crypt_decrypt'

class App < Sinatra::Application

  # Initialization of Gestpay class
  def initialize
    super
    @gestpay = RubyGestpayStarter::GestpayWsCryptDecrypt.new RubyGestpayStarter::SHOP_LOGIN, :test
  end


  get '/' do
    erb :index
  end

  post '/pay' do
    item = params['item']
    amount = params['price']
    logger.info "received request for item #{item} with price #{amount}..."

    encrypt_request = {
        shop_login: RubyGestpayStarter::SHOP_LOGIN,
        amount: amount,
        uic_code: '242'
    }
    encrypt_response = @gestpay.encrypt encrypt_request
    if encrypt_response.dig(:error_code) != "0"
      raise "Error during Encrypt, errorcode: "+encrypt_response.dig(:error_code)+ " errorDescription: " + encrypt_response.dig(:error_description)
    end
    crypted_string = encrypt_response.dig(:crypt_decrypt_string)
    erb :pay, :locals => {
        :item => item,
        :amount => amount,
        :crypted_string => crypted_string,
        :shop_login => RubyGestpayStarter::SHOP_LOGIN
    }
  end

  get '/response' do
    shop_login = params['a']
    crypted_string = params['b']

    puts "Received message from Gestpay: #{shop_login} is here"

    result = @gestpay.decrypt :shop_login => shop_login, 'CryptedString' => crypted_string

    puts result.inspect

    erb :response, :locals => {
        :result => result,
        :result_ruby => result.pretty_inspect
    }

  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end