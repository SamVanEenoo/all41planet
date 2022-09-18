class HomeController < ApplicationController

  def index
    if current_user
      redirect_to "/lists"
    else
      redirect_to "/home"
    end
  end

  def home
  end

  def lists
    @users = User.all
    @last_5_users = @users.last(5)
    @companies = Company.all
    @last_5_companies = @companies.last(5)
    @projects = Project.where(state: "Approved")
    @last_5_projects = @projects.last(5)
  end

end
