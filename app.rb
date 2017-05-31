module RubyGestpayStarter

  require 'sinatra'

  require_relative 'ruby_gestpay_starter/constants'
  require_relative "ruby_gestpay_starter/version"


  get '/' do
    erb :index
  end

  post '/pay' do
    @item = params['item']
    @amount = params['price']
    logger.info "received request for item #{@item} with price #{@amount}..."

    @shopLogin = Gestpay::SHOP_LOGIN

    @cryptedString = '123'

    erb :pay

  end
end
