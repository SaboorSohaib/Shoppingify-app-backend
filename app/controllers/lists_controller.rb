class ListsController < ApplicationController
  before_action :authenticate_request
  before_action :set_user
  before_action :set_list, only: %i[show update destroy]

  def index
    @lists = @user.lists
    render json: @lists
  end

  def show
    render json: @list
  end

  def create
    @user.lists.update_all(active: false)

    @list = @user.lists.create(list_params.merge(active: true))
    if @list.save
      render json: @list, status: :created
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def update
    @user.lists.where.not(id: @list.id).each do |list|
      list.update(active: false)
    end

    if @list.update(list_params.merge(active: true).except(:user_id))
      render json: @list, status: :ok
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    head :no_content
  end

  def deactivate
    @list = List.find(params[:id])
    @list.deactivate
  end

  private

  def set_user
    @user = User.find_by(params[:user_id])
  end

  def set_list
    @list = @user.lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :active)
  end
end
