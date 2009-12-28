class Location < ActiveRecord::Base
  has_many :weather_readings
  validate :on_earth

  #named_scope :needs_reading_update,  lambda { |*args| {:include => :weather_readings, :conditions => ["weather_readings.created_at > ?", (args.first || 6.hours.ago)] }}

  def self.needs_reading_update
    to_return = Array.new
    all = Location.all
    for location in all
      recent = location.weather_readings.most_recent.first
      if recent.nil? || recent.created_at < 6.hours.ago
        to_return << location
      end
    end
    to_return
  end

  def background_update
    client = YahooWeather::Client.new
    response = client.lookup_by_woeid(self.woeid,'c') # yeah need to make sure that we use Celsius and not Fahrenheit
    weather_reading = WeatherReading.new
    weather_reading.woeid = self.woeid
    weather_reading.reading_time = response.condition.date
    weather_reading.temperature = response.condition.temp
    weather_reading.weather_condition = response.condition.code
    weather_reading.weather_condition_string = response.condition.text
    self.weather_readings << weather_reading
  end


  def on_earth
    unless in_world?
      errors.add_to_base("There was a problem as the latitude and longitude are invalid.")
    end
  end

  # This scaling factor is used to convert between the float lat/lon that is
  # returned by the API, and the integer lat/lon equivalent that is stored in
  # the database.
  SCALE = 10000000

  # Is this node within -90 >= latitude >= 90 and -180 >= longitude >= 180
  # * returns true/false
  def in_world?
    return false if self.lat < -90 or self.lat > 90
    return false if self.lon < -180 or self.lon > 180
    return true
  end

  def lat=(l)
    self.latitude = (l * SCALE).round
  end

  def lon=(l)
    self.longitude = (l * SCALE).round
  end

  # Return WGS84 latitude
  def lat
    return self.latitude.to_f / SCALE
  end

  # Return WGS84 longitude
  def lon
    return self.longitude.to_f / SCALE
  end

end
