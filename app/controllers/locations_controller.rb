require 'yahoo-weather'

class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.xml
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.xml
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.xml
  def create
    GeoPlanet.appid = "suKDGQLV34HxfausezDebOCIJgWVVgMN.IoXX7iPhaPcG1ud6ddzCJpD7NDUojYVd29mhw--"
    @location = Location.new
    logger.debug params[:location][:woeid]
    a = GeoPlanet::Place.new(params[:location][:woeid].to_i)
    @location.woeid = params[:location][:woeid]
    @location.lat = a.latitude
    @location.lon = a.longitude
    @location.name = a.name
    @location.country = a.country

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Location was successfully created.'
        format.html { redirect_to(@location) }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = 'Location was successfully updated.'
        format.html { redirect_to(@location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end

  def update_weather
    @location = Location.find(params[:id])
    background_update
    redirect_to @location
  end

  def background_update
    client = YahooWeather::Client.new
    response = client.lookup_by_woeid(@location.woeid,'c')
    weather_reading = WeatherReading.new
    weather_reading.woeid = @location.woeid
    weather_reading.reading_time = response.condition.date
    weather_reading.temperature = response.condition.temp
    weather_reading.weather_condition = response.condition.code
    weather_reading.weather_condition_string = response.condition.text
    @location.weather_readings << weather_reading
  end
end
