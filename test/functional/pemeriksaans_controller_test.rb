require 'test_helper'

class PemeriksaansControllerTest < ActionController::TestCase
  setup do
    @pemeriksaan = pemeriksaans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pemeriksaans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pemeriksaan" do
    assert_difference('Pemeriksaan.count') do
      post :create, :pemeriksaan => @pemeriksaan.attributes
    end

    assert_redirected_to pemeriksaan_path(assigns(:pemeriksaan))
  end

  test "should show pemeriksaan" do
    get :show, :id => @pemeriksaan.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pemeriksaan.to_param
    assert_response :success
  end

  test "should update pemeriksaan" do
    put :update, :id => @pemeriksaan.to_param, :pemeriksaan => @pemeriksaan.attributes
    assert_redirected_to pemeriksaan_path(assigns(:pemeriksaan))
  end

  test "should destroy pemeriksaan" do
    assert_difference('Pemeriksaan.count', -1) do
      delete :destroy, :id => @pemeriksaan.to_param
    end

    assert_redirected_to pemeriksaans_path
  end
end
