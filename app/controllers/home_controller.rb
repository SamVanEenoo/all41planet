class HomeController < ApplicationController

  def index
    if current_user
      render :feed
    else
      @users = User.all
      @last_5_users = @users.last(5)
      @company_users = CompanyUser.all
      @last_5_company_users = @company_users.last(5)
      @projects = Project.all
      @last_5_projects = @projects.last(5)
      render :lists
    end
  end

  def lists
    @users = User.all
    @last_5_users = @users.last(5)
    @company_users = CompanyUser.all
    @last_5_company_users = @company_users.last(5)
    @projects = Project.all
    @last_5_projects = @projects.last(5)
  end

  def feed
  end
end
