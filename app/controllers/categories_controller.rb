class CategoriesController < ApplicationController
  before_action :authenticate_request
  def index; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
