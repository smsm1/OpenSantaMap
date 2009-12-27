class WeatherReading < ActiveRecord::Base
  belongs_to :location

  named_scope :most_recent, :order => "reading_time DESC", :limit => 1
end
