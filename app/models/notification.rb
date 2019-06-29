class Notification < ApplicationRecord
  belongs_to :measure

  scope :unreads, -> { where(read: false) }

  def self.with_measure_and_device
    eager_load(measure: [:device])
  end
end
