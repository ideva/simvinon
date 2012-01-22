require 'test_helper'

class MappingDataTindakanMedisControllerTest < ActionController::TestCase
  setup do
    @mapping_data_tindakan_medi = mapping_data_tindakan_medis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mapping_data_tindakan_medis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mapping_data_tindakan_medi" do
    assert_difference('MappingDataTindakanMedi.count') do
      post :create, :mapping_data_tindakan_medi => @mapping_data_tindakan_medi.attributes
    end

    assert_redirected_to mapping_data_tindakan_medi_path(assigns(:mapping_data_tindakan_medi))
  end

  test "should show mapping_data_tindakan_medi" do
    get :show, :id => @mapping_data_tindakan_medi.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mapping_data_tindakan_medi.to_param
    assert_response :success
  end

  test "should update mapping_data_tindakan_medi" do
    put :update, :id => @mapping_data_tindakan_medi.to_param, :mapping_data_tindakan_medi => @mapping_data_tindakan_medi.attributes
    assert_redirected_to mapping_data_tindakan_medi_path(assigns(:mapping_data_tindakan_medi))
  end

  test "should destroy mapping_data_tindakan_medi" do
    assert_difference('MappingDataTindakanMedi.count', -1) do
      delete :destroy, :id => @mapping_data_tindakan_medi.to_param
    end

    assert_redirected_to mapping_data_tindakan_medis_path
  end
end
