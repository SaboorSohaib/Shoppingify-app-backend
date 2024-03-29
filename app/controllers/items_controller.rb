class ItemsController < ApplicationController
  before_action :authenticate_request
  before_action :set_categorey
  before_action :set_item, only: %i[show update destroy]

  def index
    @items = @categorie.items
    render json: @items
  end

  def show
    render json: @item
  end

  # def new
  #   @item = Item.new
  # end

  def create
    @item = @categorie.items.create(item_params)
    if @item.save
      render json: @item, status: :created
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
    @item = Item.find(params[:id])
    @item.destroy
    head :no_content
  end

  def top_items
    top_items = Item
      .group(:name)
      .select('name, SUM(quantity) AS total_quantity')
      .order('total_quantity DESC')
      .limit(3) # Limit to top 3 items

    render json: top_items
  end

  def top_categories
    top_categories = Item
      .joins(:category)
      .group('categories.name')
      .select('categories.name, COUNT(items.id) AS total_count')
      .order('total_count DESC')
      .limit(3) # Limit to top 3 categories

    render json: top_categories
  end

  private

  def set_categorey
    @categorie = Category.find(params[:category_id])
  end

  def set_item
    @item = @categorie.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :note, :image, :quantity, :category_id)
  end
end
