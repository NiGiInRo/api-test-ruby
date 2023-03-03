class Api::V1::UserController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

=begin
  GET /api/users
  POST /api/users
  PUT /api/users/:id
  DELETE /api/users/:id
=end
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: { id: @user.id, name: @user.name, last_name: @user.last_name, email: @user.email }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { id: @user.id, name: @user.name, last_name: @user.last_name, email: @user.email }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { id: @user.id, name: @user.name, last_name: @user.last_name, email: @user.email }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password, :role_id)
  end
end
