class Api::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render :show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render :show
    else
      render json: @user.errors.full_messages.to_json, status: 401
    end
  end


  def update
    @user = current_user
    if @user.update(location: user_params[:location])
      render :show
    else
      render json: @user.errors.full_messages.to_json, status: 401
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :location)
  end
end
