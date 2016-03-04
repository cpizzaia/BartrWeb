class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login(@user)
      render :show
    else
      render json: {"error": "invalid credentials"}, status: 401
    end
  end

  def show
    unless current_user
      render json: {}
      return
    end
    @user = current_user
    render 'api/users/show'
  end

  def destroy
    logout
    render json: {'session_token': ''}
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
