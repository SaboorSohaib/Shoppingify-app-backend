class ListsController < ApplicationController
  def index
    @lists = List.all
    render json: @lists
  end

  def show
    @list = List.find(params[:id])
    render json: @list
  end

  def new
    @list = @user.lists.new(list_params)
  end

  def create
    @user = User.find(params[:id])
    @list = @user.lists.create(list_params)
    if @list.save
      render json: @list
    else
      render json: @list.errors
    end
  end

  def update
    @list = List.find(params[:id])
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
  end

  private

  def list_params
    params.require(:list).permit(:name, :user_id)
  end
end
