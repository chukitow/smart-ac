module DevicesDocs
  def self.superclass
    Api::V1::DevicesController
  end

  extend Apipie::DSL::Concern


  resource_description do
    resource_id 'Devices'
    formats %i[json]
    api_versions 'public'
  end


  def_param_group :device_params do
    param :serial_number, String, 'Unique serial number per device', required: true
    param :firmware_version, String, 'Semantic version for firmware', required: true
  end

  def_param_group :device_response do
    param :serial_number, String, nil, required: true
    param :firmware_version, String, nil, required: true
    param :registered_at, DateTime, nil, requried: true
  end

  api :POST, '/devices', 'Creates a device'
  header 'API_TOKEN', "CLIENT TOKEN required to perform any HTTP request", required: true
  param_group :device_params
  returns :device_response, desc: 'It returns the registered device'
  returns code: 422, desc: 'There was an error while creating the device' do
     property :error, String, desc: 'Detailed error'
  end
  def create; end
end
