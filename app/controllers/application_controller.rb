class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_assistant, :assistant_logged_in?
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

  def current_assistant
    @current_assistant ||= Assistant.find(session[:assistant_id]) if session[:assistant_id]
  end

  def assistant_logged_in?
    !!current_assistant
  end

  def require_assistant
    unless assistant_logged_in?
      flash[:alert] = "裡面太危險了，趕快回家吧！"
      redirect_to root_path
    end
  end
end