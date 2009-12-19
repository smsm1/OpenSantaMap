require 'test_helper'

class WeatherReadingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weather_readings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weather_reading" do
    assert_difference('WeatherReading.count') do
      post :create, :weather_reading => { }
    end

    assert_redirected_to weather_reading_path(assigns(:weather_reading))
  end

  test "should show weather_reading" do
    get :show, :id => weather_readings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => weather_readings(:one).to_param
    assert_response :success
  end

  test "should update weather_reading" do
    put :update, :id => weather_readings(:one).to_param, :weather_reading => { }
    assert_redirected_to weather_reading_path(assigns(:weather_reading))
  end

  test "should destroy weather_reading" do
    assert_difference('WeatherReading.count', -1) do
      delete :destroy, :id => weather_readings(:one).to_param
    end

    assert_redirected_to weather_readings_path
  end
end
