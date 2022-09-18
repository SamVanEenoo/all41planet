class CompaniesController < ApplicationController

  before_action :sanitize_fields_params, only: [:create,:update]

  def index
    @companies = Company.paginate(page: params[:page], per_page: 20)
  end

  def new
    @company = Company.new
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
  end

  def create
    @company = Company.new(company_params)
    img = ImageProcessing::MiniMagick.source(company_params[:avatar].path())
    avatar = img.crop("#{params[:company][:avatar_crop_w]}x#{params[:company][:avatar_crop_h]}+#{params[:company][:avatar_crop_x]}+#{params[:company][:avatar_crop_y]}")
          .resize_to_limit!(100, 100)
    @company.avatar.attach(io: avatar, filename: "#{params[:company][:name]}.png", content_type: "image/png")
    @company.save
    company_user = CompanyUser.new(company_id:@company.id,user_id:current_user.id)
    company_user.save

    redirect_to root_path
  end

  def sanitize_fields_params
    avatar_crop_x = params[:user][:avatar_crop_x]
    avatar_crop_y = params[:user][:avatar_crop_y]
    avatar_crop_w = params[:user][:avatar_crop_w]
    avatar_crop_h = params[:user][:avatar_crop_h]
  end

  private
  def company_params
    params.require(:company).permit(:name,:vat_number,:website,:avatar,:percentage,:avatar,:avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h)
  end

end
