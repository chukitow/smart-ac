class CreateMeasures < ActiveRecord::Migration[5.2]
  def change
    create_table :measures do |t|
      t.decimal :temperature
      t.decimal :air_humidity
      t.decimal :carbon_monoxide
      t.string :health_status

      t.references :device

      t.timestamps
    end
  end
end
