class Device < ApplicationRecord
  validates :firmware_version,
            format: Constants::SEMVER_REGEX,
            presence: true

  validates :serial_number,
            presence: true,
            uniqueness: true
end
