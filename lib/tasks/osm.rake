namespace :osm do
  desc "Update the locations that haven't been updated recently"
  task(:update_weather_readings => :environment) do
    counter = 0
    for location in Location.needs_reading_update
      location.send_later(:background_update)
      counter += 1
    end
    puts "#{counter} readings were updated"
  end
end