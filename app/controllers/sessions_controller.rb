class SessionsController < ApplicationController
  # 助理登入
  def new
    redirect_to staff_root_path if current_assistant
  end

  def create
    assistant = Assistant.find_by(email: params[:email])

    if assistant && assistant.authenticate(params[:password])
      session[:assistant_id] = assistant.id
      flash[:notice] = "Welcome, #{assistant.username}!"
      redirect_to staff_root_path
    else
      flash.now[:alert] = "請確認登入資訊!"
      render :new
    end
  end

  def destroy
    session[:assistant_id] = nil
    flash[:warning] = "你已經登出了!"
    redirect_to root_path
  end

  # 管理員登入
  def manager_new
    redirect_to admin_root_path if current_manager
  end

  def manager_create
    manager = Manager.find_by(email: params[:email])

    if manager && manager.authenticate(params[:password])
      if params[:remember_me]
        # 勾選記住我的話將使用者長久留在使用者瀏覽器
        cookies.permanent[:remember_token] = manager.remember_token
      else
        cookies[:remember_token] = manager.remember_token
      end
      flash[:notice] = "Welcome, #{manager.username}!"
      redirect_to admin_root_path
    else
      flash.now[:alert] = "請確認登入資訊!"
      render :new
    end
  end

  def manager_destroy
    cookies.delete(:remember_token)
    flash[:warning] = "你已經登出了!"
    redirect_to root_path
  end
end