 module ApplicationHelper
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end
end
