class ListsController < ApplicationController
  before_action :authenticate_request
  before_action :set_user
  before_action :set_list, only: [:show, :update, :destroy]

  def index
    @lists = @user.lists
    render json: @lists
  end

  def show
    render json: @list
  end

  def new
    @list = @user.lists.new
  end

  def create
    @list = @user.lists.create(list_params)
    if @list.save
      render json: @list,  status: :created
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      render json: @list, status: :ok
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_list
    @list = @user.lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :user_id)
  end
end
