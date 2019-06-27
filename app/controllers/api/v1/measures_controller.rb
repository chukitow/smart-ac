class Api::V1::MeasuresController < Api::V1::BaseController
  before_action :find_device

  def create
    measures = Measures::Creator.for(measure_params, @device)
    if measures.succuess?
      render json: { success: true }, status: :ok
    else
      render json: {
        success: false,
        error: measures.error
      }, status: :unprocessable_entity
    end
  end

  private

  def find_device
    @device = Device.find(params[:device_id])
  end

  def measure_params
    request.parameters[:_json]
  end
end
