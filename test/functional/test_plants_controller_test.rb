require 'test_helper'

class TestPlantsControllerTest < ActionController::TestCase
  setup do
    @test_plant = test_plants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_plants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_plant" do
    assert_difference('TestPlant.count') do
      post :create, :test_plant => @test_plant.attributes
    end

    assert_redirected_to test_plant_path(assigns(:test_plant))
  end

  test "should show test_plant" do
    get :show, :id => @test_plant.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @test_plant.to_param
    assert_response :success
  end

  test "should update test_plant" do
    put :update, :id => @test_plant.to_param, :test_plant => @test_plant.attributes
    assert_redirected_to test_plant_path(assigns(:test_plant))
  end

  test "should destroy test_plant" do
    assert_difference('TestPlant.count', -1) do
      delete :destroy, :id => @test_plant.to_param
    end

    assert_redirected_to test_plants_path
  end
end
