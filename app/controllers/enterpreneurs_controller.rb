class EnterpreneursController < ApplicationController

  def index
    @enterpreneurs = CompanyUser.paginate(page: params[:page], per_page: 20)
  end

end
