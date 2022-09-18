class UsersController < ApplicationController

  before_action :sanitize_fields_params, only: [:update]

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def new
    @login_page = true
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    accepted_formats = [".jpg",".jpeg",".png"]

    if params[:user][:avatar].nil?
      puts "A valid profile picture is required."
      flash.now[:alert] = "A valid profile picture is required."
      render :new
    elsif !accepted_formats.include?(File.extname(params[:user][:avatar]).downcase)
      puts "Only images with an jpg, jpeg or png extension are accepted."
      flash.now[:alert] = "Only images with an jpg, jpeg or png extension are accepted."
      render :new
    elsif !@user.save
      puts "Your passwords don't match. Please try again."
      flash.now[:alert] = "Your passwords don't match. Please try again."
      render :new
    else
      session[:user_id] = @user.id
      img = ImageProcessing::MiniMagick.source(params[:user][:avatar].path())
      avatar = img.crop("#{params[:user][:avatar_crop_w]}x#{params[:user][:avatar_crop_h]}+#{params[:user][:avatar_crop_x]}+#{params[:user][:avatar_crop_y]}")
            .resize_to_limit!(100, 100)
      @user.avatar.attach(io: avatar, filename: "#{params[:user][:first_name]}_#{params[:user][:last_name]}.png", content_type: "image/png")

      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if !params[:user][:avatar].nil?
      accepted_formats = [".jpg",".jpeg",".png"]
      if accepted_formats.include?(File.extname(params[:user][:avatar]).downcase)
        img = ImageProcessing::MiniMagick.source(params[:user][:avatar].path())
        avatar = img.crop("#{params[:user][:avatar_crop_w]}x#{params[:user][:avatar_crop_h]}+#{params[:user][:avatar_crop_x]}+#{params[:user][:avatar_crop_y]}")
              .resize_to_limit!(100, 100)
        @user.avatar.attach(io: avatar, filename: "#{params[:user][:first_name]}_#{params[:user][:last_name]}.png", content_type: "image/png")
      end
      @user.save
    end

    redirect_to user_path(@user)
  end

  def sanitize_fields_params
    avatar_crop_x = params[:user][:avatar_crop_x]
    avatar_crop_y = params[:user][:avatar_crop_y]
    avatar_crop_w = params[:user][:avatar_crop_w]
    avatar_crop_h = params[:user][:avatar_crop_h]
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation,:avatar,:avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h)
  end

end
