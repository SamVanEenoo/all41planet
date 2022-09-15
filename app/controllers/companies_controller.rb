class CompaniesController < ApplicationController

  def show
    @company_user = CompanyUser.find_by(company_id: params[:id])
  end

end
