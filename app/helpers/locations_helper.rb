module LocationsHelper
  def map_icon_javascript(weather_reading)
    html = "var marker = new mxn.Marker(new mxn.LatLonPoint(#{weather_reading.location.lat},#{weather_reading.location.lon}));"
    case weather_reading.weather_condition
    # See http://developer.yahoo.com/weather/#codes for more info on the codes for the codes
    when 7, 13, 14, 15, 16, 18, 41, 42, 43, 46 then
      html << "marker.setIcon(\"/images/map_symbols/snowman.png\")"
      html << "map.addMarker(marker);"
    else
      html << ""
    end
  end
end

