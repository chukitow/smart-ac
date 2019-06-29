class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.boolean :read, default: false
      t.references :measure

      t.timestamp
    end
  end
end
