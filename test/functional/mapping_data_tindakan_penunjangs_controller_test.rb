require 'test_helper'

class MappingDataTindakanPenunjangsControllerTest < ActionController::TestCase
  setup do
    @mapping_data_tindakan_penunjang = mapping_data_tindakan_penunjangs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mapping_data_tindakan_penunjangs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mapping_data_tindakan_penunjang" do
    assert_difference('MappingDataTindakanPenunjang.count') do
      post :create, :mapping_data_tindakan_penunjang => @mapping_data_tindakan_penunjang.attributes
    end

    assert_redirected_to mapping_data_tindakan_penunjang_path(assigns(:mapping_data_tindakan_penunjang))
  end

  test "should show mapping_data_tindakan_penunjang" do
    get :show, :id => @mapping_data_tindakan_penunjang.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mapping_data_tindakan_penunjang.to_param
    assert_response :success
  end

  test "should update mapping_data_tindakan_penunjang" do
    put :update, :id => @mapping_data_tindakan_penunjang.to_param, :mapping_data_tindakan_penunjang => @mapping_data_tindakan_penunjang.attributes
    assert_redirected_to mapping_data_tindakan_penunjang_path(assigns(:mapping_data_tindakan_penunjang))
  end

  test "should destroy mapping_data_tindakan_penunjang" do
    assert_difference('MappingDataTindakanPenunjang.count', -1) do
      delete :destroy, :id => @mapping_data_tindakan_penunjang.to_param
    end

    assert_redirected_to mapping_data_tindakan_penunjangs_path
  end
end
