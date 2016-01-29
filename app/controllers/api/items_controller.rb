class Api::ItemsController < ApplicationController

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
    if @item.update(item_params)
      render :show
    else
      render json: @item.errors.full_messages.to_json, status: 401
    end
  end

  def destroy
    current_user.items.find(params[:id]).destroy
    @item = Item.new
    render :show
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :image)
  end
end
