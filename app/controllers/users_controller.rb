class UsersController < ApplicationController
  def my_portfolio
    @track_stock = current_user.stocks
    
  end
  def show
   @user = User.find( params[:id])
   @user_stock = User
  end
end
