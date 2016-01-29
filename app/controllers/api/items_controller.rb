class Api::UsersController < ApplicationController

  def show
    @item = Item.find(params[:id])
    render :show
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      render :show
    else
      render json: @item.errors.full_messages.to_json, status: 401
    end
  end


  def update
    @item = current_user.items.find(params[:id])
    if @item.save
      render :show
    else
      render json: @item.errors.full_messages.to_json, status: 401
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :image)
  end
end
