class Admin::UsersController < AdminController
  layout "admin"
  before_action :require_manager

  # 針對import_usere關掉表單token驗證
  skip_before_action :verify_authenticity_token, only: [:import_user]

  def index
    @user_page = @users = User.recent.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.includes(orders: [:info, :items]).find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def import_user
    begin
      user = User.new
      user.user_name = params[:user_name]
      user.real_name = params[:real_name]
      user.gender = params[:gender]
      user.phone = params[:phone]
      user.address = params[:address]
      user.uid = params[:uid]
      user.save!
      render json: "Successfully Create"
    rescue Exception => e
      render json: "Error"
    end    
  end

  def show_uid
    @user = User.find_by(uid: params[:uid])

    respond_to do |format|
      format.json { render json: @user }
    end
  end

  def update
    user = User.find_by(uid: params[:id])
    begin
      user.user_name = params[:user_name]
      user.real_name = params[:real_name]
      user.gender = params[:gender]
      user.phone = params[:phone]
      user.address = params[:address]
      user.save!
      render json: "Successfully Update"
    rescue Exception => e
      render json: "Error"
    end
  end  
end