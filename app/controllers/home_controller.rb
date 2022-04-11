class HomeController < ApplicationController

  def index
    @users = User.all
    #@users = @users.order("position").reverse.first(5)
  end
end
