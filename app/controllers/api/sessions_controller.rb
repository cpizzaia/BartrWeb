class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login(@user)
      render :show
    else
      render json: @user.errors.full_messages.to_json, status: 401
    end
  end

  def show
    unless current_user
      render json: {}
      return
    end
    @user = current_user
    render 'api/user/show'
  end

  def destroy
    session[:session_token] = nil
    @user = User.new
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
