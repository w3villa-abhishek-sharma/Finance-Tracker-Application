class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    has_many :user_stocks
    has_many :stocks, through: :user_stocks
    has_many :friendships
    has_many :friends , through: :friendships

    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

    def full_name
      return "#{first_name} #{last_name}" if first_name || last_name

      "anonyomous"
      
    end
    
    def self.search_user(param)
      param.strip!
      to_send_back = (search_first_name(param)+search_last_name(param) + search_email(param)).uniq
      return nil unless to_send_back
      to_send_back  
    end

    def self.search_first_name(param)
      matches('first_name',param)
    end
   
    def self.search_last_name(param)
      
      matches('last_name',param)

    end
   
    def self.search_email(param)
      
      matches('email',param)

    end
   
    def self.check_db_user(friend)
      User.where(first_name: friend).first
    end

    def self.matches(field_name,param)
    where("#{field_name} like?", "%#{param}%")
      
    end

end
