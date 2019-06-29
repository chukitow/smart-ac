class Measure < ApplicationRecord
  WARNING_STATUS = ['needs_service', 'needs_new_filter', 'gas_leak'].freeze
  CARBON_MONOXIDE_LIMIT = 9

  belongs_to :device

  has_many :notifications

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
     not_healthy? || hight_carbon_monoxide?
  end

  def not_healthy?
    WARNING_STATUS.include?(self.health_status)
  end

  def hight_carbon_monoxide?
    self.carbon_monoxide > CARBON_MONOXIDE_LIMIT
  end
end
