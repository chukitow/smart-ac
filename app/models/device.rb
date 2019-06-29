class Device < ApplicationRecord
  has_many :measures

  validates :firmware_version,
            format: Constants::SEMVER_REGEX,
            presence: true

  validates :serial_number,
            presence: true,
            uniqueness: true

  def measures_with_unread_notifications
    measures.joins(:notifications).merge(Notification.unreads)
  end

  def to_h
    self.slice(:id, :serial_number, :firmware_version)
    .merge({
      registered_at: self.created_at
    })
  end
end
