class WeatherReadingsController < ApplicationController
  # GET /weather_readings
  # GET /weather_readings.xml
  def index
    @weather_readings = WeatherReading.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weather_readings }
    end
  end

  # GET /weather_readings/1
  # GET /weather_readings/1.xml
  def show
    @weather_reading = WeatherReading.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weather_reading }
    end
  end

  # GET /weather_readings/new
  # GET /weather_readings/new.xml
  def new
    @weather_reading = WeatherReading.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weather_reading }
    end
  end

  # GET /weather_readings/1/edit
  def edit
    @weather_reading = WeatherReading.find(params[:id])
  end

  # POST /weather_readings
  # POST /weather_readings.xml
  def create
    @weather_reading = WeatherReading.new(params[:weather_reading])

    respond_to do |format|
      if @weather_reading.save
        flash[:notice] = 'WeatherReading was successfully created.'
        format.html { redirect_to(@weather_reading) }
        format.xml  { render :xml => @weather_reading, :status => :created, :location => @weather_reading }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weather_reading.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weather_readings/1
  # PUT /weather_readings/1.xml
  def update
    @weather_reading = WeatherReading.find(params[:id])

    respond_to do |format|
      if @weather_reading.update_attributes(params[:weather_reading])
        flash[:notice] = 'WeatherReading was successfully updated.'
        format.html { redirect_to(@weather_reading) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weather_reading.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_readings/1
  # DELETE /weather_readings/1.xml
  def destroy
    @weather_reading = WeatherReading.find(params[:id])
    @weather_reading.destroy

    respond_to do |format|
      format.html { redirect_to(weather_readings_url) }
      format.xml  { head :ok }
    end
  end
end
