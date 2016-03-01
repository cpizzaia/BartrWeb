class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    byebug
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
    render 'api/users/show'
  end

  def destroy
    logout(@user)
    @user = User.new
    render json: {}
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
