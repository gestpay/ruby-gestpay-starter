module RubyGestpayStarter


  class GestpayWsCryptDecrypt

    TEST_WSDL='https://testecomm.sella.it/gestpay/GestPayWS/WsCryptDecrypt.asmx?wsdl'
    PROD_WSDL='https://ecommS2S.sella.it/gestpay/GestPayWS/WsCryptDecrypt.asmx?wsdl'

    def initialize(shopLogin, environment= :test)
      @shopLogin = shopLogin
      @environment = environment
      if @environment == :test
        @client = Savon.client(wsdl: TEST_WSDL)
      else
        @client = Savon.client(wsdl: PROD_WSDL)
      end

    end


    def encrypt message

      check_not_null message, 'message'
      check_not_null message[:shop_login], 'message[:shop_login]'
      check_not_null message[:uic_code], 'message[:uic_code]'
      check_not_null message[:amount], 'message[:amount]'
      message[:shop_transaction_id] = Time.now.strftime('%Y%m%d_%H%M:%S.%L') if message[:shop_transaction_id].nil?

      response = @client.call(:encrypt, message: message)

    end

    private
    def check_not_null value, name
      if value.nil?
        raise "#{name} cannot be null"
      end
    end

  end
end
