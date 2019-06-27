class Measure < ApplicationRecord
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
end
