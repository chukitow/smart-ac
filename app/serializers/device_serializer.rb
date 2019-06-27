class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :serial_number, :firmware_version, :registration_date

  def registration_date
    object.created_at
  end
end
