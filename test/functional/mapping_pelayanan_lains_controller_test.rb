require 'test_helper'

class MappingPelayananLainsControllerTest < ActionController::TestCase
  setup do
    @mapping_pelayanan_lain = mapping_pelayanan_lains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mapping_pelayanan_lains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mapping_pelayanan_lain" do
    assert_difference('MappingPelayananLain.count') do
      post :create, :mapping_pelayanan_lain => @mapping_pelayanan_lain.attributes
    end

    assert_redirected_to mapping_pelayanan_lain_path(assigns(:mapping_pelayanan_lain))
  end

  test "should show mapping_pelayanan_lain" do
    get :show, :id => @mapping_pelayanan_lain.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mapping_pelayanan_lain.to_param
    assert_response :success
  end

  test "should update mapping_pelayanan_lain" do
    put :update, :id => @mapping_pelayanan_lain.to_param, :mapping_pelayanan_lain => @mapping_pelayanan_lain.attributes
    assert_redirected_to mapping_pelayanan_lain_path(assigns(:mapping_pelayanan_lain))
  end

  test "should destroy mapping_pelayanan_lain" do
    assert_difference('MappingPelayananLain.count', -1) do
      delete :destroy, :id => @mapping_pelayanan_lain.to_param
    end

    assert_redirected_to mapping_pelayanan_lains_path
  end
end
