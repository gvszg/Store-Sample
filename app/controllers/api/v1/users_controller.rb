class Api::V1::UsersController < ApiController
  # TODO 重構整理
  def create
    user = User.find_or_initialize_by(email: params[:email])
    user.user_name = params[:user_name]
    user.real_name = params[:real_name]
    user.gender = params[:gender]
    user.phone = params[:phone]
    user.address = params[:address]
    user.uid = params[:uid]
    user.email = params[:email]
    user.save!
    render json: "Successfully Create"
  end

  def show
    user = User.find_by(uid: params[:id])
    result_user = {}
    result_user[:uid] = user.uid
    result_user[:gender] = user.gender
    result_user[:user_name] = user.user_name
    result_user[:real_name] = user.real_name
    result_user[:phone] = user.phone
    result_user[:address] = user.address
    render json: result_user
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