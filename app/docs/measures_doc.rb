module MeasuresDoc
  def self.superclass
    Api::V1::MeasuresController
  end

  extend Apipie::DSL::Concern


  resource_description do
    resource_id 'Measure'
    formats %i[json]
    api_versions 'public'
  end

  def_param_group :measure do
    param :temperature, Integer, 'Temprature sensor unit', required: true
    param :air_humidity, Integer, 'Air humidity percentage', required: true
    param :carbon_monoxide, Integer, 'Carbon monoxide PPM', required: true
    param :health_status, String, 'Health status string', required: true
  end

  api :POST, '/devices/:device_id/measures', "Register measurements for devices sensors"

  header 'API_TOKEN', "CLIENT TOKEN required to perform any HTTP request", required: true
  param_group :measure, desc: 'Array with multiple sensors data'
  returns code: 200, desc: "Device sensors data were added successfully"

  returns code: 422, desc: 'There was an error while registering sensors data' do
     property :error, String, desc: 'Detailed error'
  end
  def create; end
end
