class HomeController < ApplicationController

  def index
    render :index
  end

  def lists
    @users = User.all
    @last_5_users = @users.last(5)
    @company_users = CompanyUser.all
    @last_5_company_users = @company_users.last(5)
    @projects = Project.all
    @last_5_projects = @projects.last(5)
  end

end
