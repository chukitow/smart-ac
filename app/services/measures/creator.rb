# TODO: Create custom StandardError

module Measures
  class Creator
    attr_reader :error

    def self.for(params, device)
      service = new(params, device)
      service.perform unless service.valid_bulk?
      service
    end

    def initialize(params, device)
      @params = params
      @device = device
    end

    def perform
      @device.transaction do
        @device.measures.create!(measures)
      end
      rescue
        @error = "Something went wrong while storing sensor's data"
    end

    def succuess?
      @error.nil?
    end

    def valid_bulk?
      return @error = 'Unprocessable Entity' unless valid_payload?
      return @error = 'Bulk limit was reached' if limit_size_reached?
    end

    private

    def valid_payload?
      @params.is_a?(Array)
    end

    def limit_size_reached?
      @params.size > 500
    end

    def measures
      @params.map { |measure| measure.slice(*measure_params) }
    end

    def measure_params
      [:temperature, :air_humidity, :carbon_monoxide, :health_status]
    end
  end
end
