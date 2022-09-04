class SessionsController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])

    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = "Something went wrong!"
      redirect_to login_sessions_path, turbolinks: false
    end
  end

  def login
    @login_page = true
  end

  def logout
    session.delete(:user_id)
    redirect_to login_sessions_path, turbolinks: false
  end

end
