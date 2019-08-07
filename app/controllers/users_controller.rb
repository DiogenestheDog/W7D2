class UsersController < ApplicationController
    def new
    end

    def create
        @user = User.new(user_params)
        @user.password = user_params[:password]
        @user.save!
        login!(@user)
        render plain: "user saved probably"
    end

    def show
        
    end
    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
