class Stock < ApplicationRecord


    has_many :user_stocks
    has_many :stocks, through: :user_stocks 

    validates :ticker, :name , presence: true

    def self.new_lookup(name)
        client = IEX::Api::Client.new(
            publishable_token: 'pk_3d6bbacde6f64f2abd5c868cee872eb1',
            secret_token:  "sk_233cdd40821948d0b76b69e927b9fcb3",
            endpoint: 'https://cloud.iexapis.com/v1'
          )
            # client.price(name)    
        begin
            new(ticker: name, name: client.company(name).company_name, last_price:  client.price(name))
        rescue => exception
            nil 
        end
    end

    def self.check_db(ticker)
        Stock.where(ticker: ticker).first
      
    end
end
