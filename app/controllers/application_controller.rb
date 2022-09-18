require "mini_magick"

class ApplicationController < ActionController::Base
  before_action :set_locale

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end


  def set_locale
    I18n.locale = params[:language] || extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = request.host.split('.').last
    if "be"
      "nl"
    else
      "en"
    end
  end

end
