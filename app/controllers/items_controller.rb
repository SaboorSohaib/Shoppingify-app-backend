class ItemsController < ApplicationController

  before_action :set_list
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @items = @list.items
    render json: @items
  end

  def show
    render json: @item
  end

  def new
    @item = Item.new
  end

  def create
    @item = @list.items.create(item_params)
    if @item.save
      render json: @item,  status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      render json: @item, status: :ok
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :note, :image, :category_id)
  end
end
