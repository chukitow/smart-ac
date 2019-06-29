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
        measures.each do |measure|
          measure = @device.measures.create!(measure)
          create_notification(measure)
        end
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

    def create_notification(measure)
      return unless measure.notificable?
      Notification.create(measure: measure) if should_be_reported?(measure)
    end

    def should_be_reported?(measure)
      unread_notifications.empty? ||
      measure.not_healthy? && !unread_notifications.any?(&:not_healthy?) ||
      measure.hight_carbon_monoxide? && !unread_notifications.any?(&:hight_carbon_monoxide?)
    end

    def unread_notifications
      @unread_notifications ||= @device.measures_with_unread_notifications
    end

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
