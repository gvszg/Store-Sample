class AdminController < ActionController::Base
  layout "admin"

  helper_method :current_manager, :manager_logged_in?

  def current_manager
    @current_manager ||= Manager.find_by(remember_token: cookies[:remember_token]) if cookies[:remember_token]
  end

  def manager_logged_in?
    !!current_manager
  end

  def require_manager
    unless manager_logged_in?
      flash[:alert] = "裡面太危險了，趕快回家吧！"
      redirect_to root_path
    end
  end
end