class ProjectsController < ApplicationController

  before_action :sanitize_fields_params, only: [:create,:update]

  def index
    @projects = Project.where(state:"Approved").paginate(page: params[:page], per_page: 20)
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    @project.state = "In review"
    img = ImageProcessing::MiniMagick.source(project_params[:avatar].path())
    avatar = img.crop("#{params[:project][:avatar_crop_w]}x#{params[:project][:avatar_crop_h]}+#{params[:project][:avatar_crop_x]}+#{params[:project][:avatar_crop_y]}")
          .resize_to_limit!(100, 100)
    @project.avatar.attach(io: avatar, filename: "#{params[:project][:name]}.png", content_type: "image/png")
    @project[:user_id] = current_user.id
    @project.save

    flash[:info] = "Je aanvraag is in behandeling. We laten iets weten van zodra deze is goedgekeurd."
    redirect_to user_path(current_user.id)
  end

  def sanitize_fields_params
    avatar_crop_x = params[:project][:avatar_crop_x]
    avatar_crop_y = params[:project][:avatar_crop_y]
    avatar_crop_w = params[:project][:avatar_crop_w]
    avatar_crop_h = params[:project][:avatar_crop_h]
  end

  private
  def project_params
    params.require(:project).permit(:name,:description,:website,:climate_advantage,:avatar,:avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h)
  end
end
