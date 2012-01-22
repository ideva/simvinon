require 'test_helper'

class MappingDataPemeriksaansControllerTest < ActionController::TestCase
  setup do
    @mapping_data_pemeriksaan = mapping_data_pemeriksaans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mapping_data_pemeriksaans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mapping_data_pemeriksaan" do
    assert_difference('MappingDataPemeriksaan.count') do
      post :create, :mapping_data_pemeriksaan => @mapping_data_pemeriksaan.attributes
    end

    assert_redirected_to mapping_data_pemeriksaan_path(assigns(:mapping_data_pemeriksaan))
  end

  test "should show mapping_data_pemeriksaan" do
    get :show, :id => @mapping_data_pemeriksaan.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mapping_data_pemeriksaan.to_param
    assert_response :success
  end

  test "should update mapping_data_pemeriksaan" do
    put :update, :id => @mapping_data_pemeriksaan.to_param, :mapping_data_pemeriksaan => @mapping_data_pemeriksaan.attributes
    assert_redirected_to mapping_data_pemeriksaan_path(assigns(:mapping_data_pemeriksaan))
  end

  test "should destroy mapping_data_pemeriksaan" do
    assert_difference('MappingDataPemeriksaan.count', -1) do
      delete :destroy, :id => @mapping_data_pemeriksaan.to_param
    end

    assert_redirected_to mapping_data_pemeriksaans_path
  end
end
