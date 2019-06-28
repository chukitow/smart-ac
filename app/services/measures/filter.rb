module Measures
  class Filter
    FILTERS = {
      today: 'day',
      this_week: 'week',
      this_month: 'month',
      this_year: 'year'
    }.freeze

    def self.filters_collection
      FILTERS.keys.map {|key| [key.to_s.humanize, FILTERS[key]] }
    end

    def initialize(params, device)
      @params = params
      @device = device
    end

    def temperature
      @temperature ||= sensor_data(:temperature)
    end

    def air_humidity
      @air_humidity ||= sensor_data(:air_humidity)
    end

    def carbon_monoxide
      @carbon_monoxide||= sensor_data(:carbon_monoxide)
    end

    private

    def sensor_data(sensor)
      @device.measures.where(created_at: date_range(sensor)).pluck(:created_at, sensor)
    end

    def date_range(sensor)
      date = @params.dig(:filter, sensor).presence || 'day'
      Date.today.send("beginning_of_#{date}")..Date.today.send("end_of_#{date}")
    end
  end
end
