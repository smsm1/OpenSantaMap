class CreateWeatherReadings < ActiveRecord::Migration
  def self.up
    create_table :weather_readings do |t|
      t.integer :location_id
      t.integer :woeid
      t.timestamp :reading_time
      t.integer :temperature
      t.integer :weather_condition
      t.string :weather_condition_string

      t.timestamps
    end
    add_index :weather_readings, :location_id
  end

  def self.down
    drop_table :weather_readings
  end
end
