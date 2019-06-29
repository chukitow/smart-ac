1.upto(10) do |x|
  device = Device.create(serial_number: "00000#{x}", firmware_version: '2.0.0')
  1.upto(100) do |y|
    measure_attributes = {
      temperature: (1..100).to_a.sample,
      air_humidity: (1..100).to_a.sample,
      carbon_monoxide: (1..100).to_a.sample,
      health_status: 'working',
      device_id: device.id
    }

    measure = Measure.create(measure_attributes)
    measure.update(created_at: (Date.today.beginning_of_year..Date.today).to_a.sample)
  end
end
