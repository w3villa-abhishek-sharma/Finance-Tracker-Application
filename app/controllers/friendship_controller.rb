class FriendshipController < ApplicationController
    before_action :set_friends
    def index
        # @friends = current_user.friends
    end

    def search

        # @friend = User.where(first_name: params[:friend]).first
        @the_friends = User.search_user(params[:friend])
        # debugger
        if @the_friends 
          
            render :index
        else
            flash[:alert] = "Please enter a valid user name"
            redirect_to friendship_index_path
        end

    end

    def create
        
        friend = User.check_db_user(params[:friend])
        
        if !current_user.friends.where(id:friend.id).exists?
        @user_friend = Friendship.create(user: current_user, friend: friend)
        flash[:notice] = " #{friend.first_name} is successfully added to your account"

        redirect_to friendship_index_path
        
         end

    end

    def destroy
        friend = User.find(params[:id])
        user_friend = Friendship.where(user_id: current_user.id,friend_id: friend.id).first
        user_friend.destroy 
        redirect_to friendship_index_path

    end


    private

    def set_friends
        @friends = current_user.friends
    end


end