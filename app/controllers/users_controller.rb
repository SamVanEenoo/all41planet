class UsersController < ApplicationController

  before_action :sanitize_fields_params, only: [:update]

  def index
    @user = User.all.first
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new, notice: "Something went wrong"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:password,:password_confirmation,:avatar)
  end
end
