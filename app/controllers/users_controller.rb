class UsersController < ApplicationController

  before_action :sanitize_fields_params, only: [:update]

  def index
    @user = User.all.first
  end

  def update
    respond_to do |format|
      current_user.update(user_params)
      format.html { redirect_to root_path }
    end
  end

  private
  def user_params
    list_params_allowed = [:image,:logo_crop_x, :logo_crop_y, :logo_crop_h, :logo_crop_w]
    params.require(:user).permit(list_params_allowed)
  end

  def sanitize_fields_params
    $logo_crop_x = params[:user][:logo_crop_x]
    $logo_crop_y = params[:user][:logo_crop_y]
    $logo_crop_w = params[:user][:logo_crop_w]
    $logo_crop_h = params[:user][:logo_crop_h]
  end
end
