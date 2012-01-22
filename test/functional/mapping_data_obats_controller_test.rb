require 'test_helper'

class MappingDataObatsControllerTest < ActionController::TestCase
  setup do
    @mapping_data_obat = mapping_data_obats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mapping_data_obats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mapping_data_obat" do
    assert_difference('MappingDataObat.count') do
      post :create, :mapping_data_obat => @mapping_data_obat.attributes
    end

    assert_redirected_to mapping_data_obat_path(assigns(:mapping_data_obat))
  end

  test "should show mapping_data_obat" do
    get :show, :id => @mapping_data_obat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mapping_data_obat.to_param
    assert_response :success
  end

  test "should update mapping_data_obat" do
    put :update, :id => @mapping_data_obat.to_param, :mapping_data_obat => @mapping_data_obat.attributes
    assert_redirected_to mapping_data_obat_path(assigns(:mapping_data_obat))
  end

  test "should destroy mapping_data_obat" do
    assert_difference('MappingDataObat.count', -1) do
      delete :destroy, :id => @mapping_data_obat.to_param
    end

    assert_redirected_to mapping_data_obats_path
  end
end
