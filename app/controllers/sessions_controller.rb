class SessionsController < ApplicationController
  # render login page
  def new
  end

  # log user in 
  def create
    @user = User::find_by_credentials(params[:user][:email], params[:user][:password])
    redirect_to users_url(params[:sessions][:user_id])
  end

  def destroy
    logout!(current_user)
    redirect_to new_sessions_url
  end
end
