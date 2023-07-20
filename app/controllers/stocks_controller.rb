class StocksController < ApplicationController
  
     def search
    
      @stock = Stock.new_lookup(params[:stock])
      @track_stock = current_user.stocks
      # render json: stock
      if params[:stock].present?
         if @stock

        return render 'users/my_portfolio'
         else 
          flash[:alert] = "Please enter a valid symbol"
          redirect_to my_portfolio_path
        end

      else
        flash[:alert] = "please enter a symbol to search"
        redirect_to my_portfolio_path
      end
    end

    def result  

     end
end
  