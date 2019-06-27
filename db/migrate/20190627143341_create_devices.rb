class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :serial_number
      t.string :firmware_version

      t.timestamps
    end
  end
end
