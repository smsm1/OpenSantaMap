class Location < ActiveRecord::Base
  has_many :weather_readings
end
