require "mini_magick"

class UsersController < ApplicationController

  before_action :sanitize_fields_params, only: [:update]

  def index
    @user = User.all.first
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    img = ImageProcessing::MiniMagick.source(user_params[:avatar].path())
    avatar = img.crop("#{params[:user][:avatar_crop_w]}x#{params[:user][:avatar_crop_h]}+#{params[:user][:avatar_crop_x]}+#{params[:user][:avatar_crop_y]}")
          .resize_to_limit!(100, 100)
    @user.avatar.attach(io: avatar, filename: "#{user_params[:first_name]}_#{user_params[:last_name]}.png", content_type: "image/png")


    if @user.save
      session[:user_id] = @user.id

      if company_params
        if company_params["show_company"] == "true"
          @company = Company.new(company_params)
          img = ImageProcessing::MiniMagick.source(company_params[:company_logo].path())
          avatar = img.crop("#{params[:user][:company][:company_logo_crop_w]}x#{params[:user][:company][:company_logo_crop_h]}+#{params[:user][:company][:company_logo_crop_x]}+#{params[:user][:company][:company_logo_crop_y]}")
            .resize_to_limit!(100, 100)
          @company.avatar.attach(io: avatar, filename: "#{params[:user][:company][:name]}.png", content_type: "image/png")
          @company.save
          company_user = CompanyUser.new(company_id:@company.id,user_id:@user.id)
          company_user.save
        end
      end

      if project_params
        if project_params["show_project"] == "true"
          @project = Project.new(project_params)
          img = ImageProcessing::MiniMagick.source(project_params[:project_logo].path())
          avatar = img.crop("#{params[:user][:project][:project_logo_crop_w]}x#{params[:user][:project][:project_logo_crop_h]}+#{params[:user][:project][:project_logo_crop_x]}+#{params[:user][:project][:project_logo_crop_y]}")
            .resize_to_limit!(100, 100)
          @project.avatar.attach(io: avatar, filename: "#{params[:user][:project][:name]}.png", content_type: "image/png")
          @project.save
          project_user = ProjectUser.new(project_id:@project.id,user_id:@user.id)
          project_user.save
        end
      end

      redirect_to root_path

    else
      render :new, notice: "Something went wrong"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    respond_to do |format|
      @user.update(user_params)
      format.html { redirect_to root_path }
    end
  end

  def sanitize_fields_params
    logo_crop_x = params[:user][:logo_crop_x]
    logo_crop_y = params[:user][:logo_crop_y]
    logo_crop_w = params[:user][:logo_crop_w]
    logo_crop_h = params[:user][:logo_crop_h]
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation,:avatar,:image,:logo_crop_x,:logo_crop_y,:logo_crop_h,:logo_crop_w)
  end

  def company_params
    if params[:user][:company]
      params.require(:user).require(:company).permit(:name,:vat_number,:website,:company_logo,:show_company)
    end
  end

  def project_params
    if params[:user][:project]
      params.require(:user).require(:project).permit(:name,:description,:website,:project_logo,:show_project)
    end
  end

end
