class UsersController < ApplicationController

  before_action :sanitize_fields_params, only: [:update]

  def index
    @user = User.all.first
  end

  def new
    @login_page = true
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if !params[:user][:avatar].nil?
      accepted_formats = [".jpg",".jpeg",".png"]
      if accepted_formats.include?(File.extname(params[:user][:avatar].downcase))
        img = ImageProcessing::MiniMagick.source(params[:user][:avatar].path())
        avatar = img.crop("#{params[:user][:avatar_crop_w]}x#{params[:user][:avatar_crop_h]}+#{params[:user][:avatar_crop_x]}+#{params[:user][:avatar_crop_y]}")
              .resize_to_limit!(100, 100)
        @user.avatar.attach(io: avatar, filename: "#{params[:user][:first_name]}_#{params[:user][:last_name]}.png", content_type: "image/png")


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
          flash.now[:alert] = "Your passwords don't match. Please try again."
          render :new
        end
      else
        flash.now[:alert] = "Only images with an jpg, jpeg or png extension are accepted."
        render :new
      end
    else
      flash.now[:alert] = "A valid profile picture is required."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # respond_to do |format|
    #   @user.update(user_params)
    #   format.html { redirect_to root_path }
    # end

    @user = User.find(params[:id])
    @user.update(user_params)
    if !params[:user][:avatar].nil?
      accepted_formats = [".jpg",".jpeg",".png"]
      if accepted_formats.include?(File.extname(params[:user][:avatar]))
        img = ImageProcessing::MiniMagick.source(params[:user][:avatar].path())
        avatar = img.crop("#{params[:user][:avatar_crop_w]}x#{params[:user][:avatar_crop_h]}+#{params[:user][:avatar_crop_x]}+#{params[:user][:avatar_crop_y]}")
              .resize_to_limit!(100, 100)
        @user.avatar.attach(io: avatar, filename: "#{params[:user][:first_name]}_#{params[:user][:last_name]}.png", content_type: "image/png")
      end
      @user.save
    end
    redirect_to user_path(@user)
  end

  def influencers
    @influencers = User.paginate(page: params[:page], per_page: 20)
  end

  def enterpreneurs
    @enterpreneurs = CompanyUser.paginate(page: params[:page], per_page: 20)
  end

  def projects
    @projects = Project.paginate(page: params[:page], per_page: 20)
  end

  def sanitize_fields_params
    logo_crop_x = params[:user][:logo_crop_x]
    logo_crop_y = params[:user][:logo_crop_y]
    logo_crop_w = params[:user][:logo_crop_w]
    logo_crop_h = params[:user][:logo_crop_h]
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation,:avatar,:image, :company, :project, :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h)
  end

  def company_params
    params.require(:user).require(:company).permit(:name,:vat_number,:website,:company_logo,:percentage,:show_company)
  end

  def project_params
    params.require(:user).require(:project).permit(:name,:description,:website,:project_logo,:climate_advantage,:show_project)
  end

end
