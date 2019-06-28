class Measure < ApplicationRecord
  WARNING_STATUS = ['needs_service', 'needs_new_filter', 'gas_leak'].freeze

  belongs_to :device

  validates :air_humidity,
              presence: true,
              numericality: true

  validates :carbon_monoxide,
              presence: true,
              numericality: true

  validates :health_status,
              presence: true,
              length: { maximum: 150 }

  validates :temperature,
              presence: true,
              numericality: true

  def notificable?
    WARNING_STATUS.include?(self.health_status)
  end
end
