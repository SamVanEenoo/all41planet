class MembersController < ApplicationController

  def index
    @members = User.paginate(page: params[:page], per_page: 20)
  end

  def show
    @member = User.find(params[:id])
  end
end
