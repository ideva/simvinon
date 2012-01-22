require 'test_helper'

class TindakanMedisControllerTest < ActionController::TestCase
  setup do
    @tindakan_medi = tindakan_medis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tindakan_medis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tindakan_medi" do
    assert_difference('TindakanMedi.count') do
      post :create, :tindakan_medi => @tindakan_medi.attributes
    end

    assert_redirected_to tindakan_medi_path(assigns(:tindakan_medi))
  end

  test "should show tindakan_medi" do
    get :show, :id => @tindakan_medi.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @tindakan_medi.to_param
    assert_response :success
  end

  test "should update tindakan_medi" do
    put :update, :id => @tindakan_medi.to_param, :tindakan_medi => @tindakan_medi.attributes
    assert_redirected_to tindakan_medi_path(assigns(:tindakan_medi))
  end

  test "should destroy tindakan_medi" do
    assert_difference('TindakanMedi.count', -1) do
      delete :destroy, :id => @tindakan_medi.to_param
    end

    assert_redirected_to tindakan_medis_path
  end
end
