class HomeController < ApplicationController

  def index
    @users = User.all
    @last_5_users = @users.last(5)
    #@users = @users.order("position").reverse.first(5)
  end
end
