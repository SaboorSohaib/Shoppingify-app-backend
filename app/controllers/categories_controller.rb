class CategoriesController < ApplicationController
  def index
  end

  def new
    @category = category.new
  end

  def create
    @category = category.create(category_params)
    if @category.save
      render json: @category,  status: :created
    else
      render json: @category.errors, , status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
