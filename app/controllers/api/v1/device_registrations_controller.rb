class Api::V1::DeviceRegistrationsController < ApiController
  def create
    if DeviceRegistration.find_or_create_by!(registration_id: params[:registration_id])
      render json: "Success：新增裝置完成"
    end
  end
end