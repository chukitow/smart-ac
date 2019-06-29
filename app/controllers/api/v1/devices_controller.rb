class Api::V1::DevicesController < Api::V1::BaseController
  def create
    device = Device.new(device_params)

    if device.save
      render json: device.to_h, status: :ok
    else
      render json: {
        error: device.errors.full_messages.shift
      }, status: :unprocessable_entity
    end
  end

  private
  def device_params
    params.permit(:serial_number, :firmware_version)
  end
end
