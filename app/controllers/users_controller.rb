class UsersController < ApplicationController

  before_action :sanitize_fields_params, only: [:update]

  def index
    @user = User.all.first
  end

  def new
  end

end
