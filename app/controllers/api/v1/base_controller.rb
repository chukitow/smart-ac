class Api::V1::BaseController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_cors
  before_action :authenticate_client

  private

  def set_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def authenticate_client
    client_token = request.headers['HTTP_API_TOKEN']
    unless ApiClient.exists?(token: client_token)
      return render json: {}, status: :unauthorized
    end
  end
end
