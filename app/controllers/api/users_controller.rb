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
    current_user.update!(user_params)
    @user = current_user
    if @user.save
      render :show
    else
      render json: @user.errors.full_messages.to_json, status: 401
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :location)
  end
end
