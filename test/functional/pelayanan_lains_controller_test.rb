require 'test_helper'

class PelayananLainsControllerTest < ActionController::TestCase
  setup do
    @pelayanan_lain = pelayanan_lains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pelayanan_lains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pelayanan_lain" do
    assert_difference('PelayananLain.count') do
      post :create, :pelayanan_lain => @pelayanan_lain.attributes
    end

    assert_redirected_to pelayanan_lain_path(assigns(:pelayanan_lain))
  end

  test "should show pelayanan_lain" do
    get :show, :id => @pelayanan_lain.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pelayanan_lain.to_param
    assert_response :success
  end

  test "should update pelayanan_lain" do
    put :update, :id => @pelayanan_lain.to_param, :pelayanan_lain => @pelayanan_lain.attributes
    assert_redirected_to pelayanan_lain_path(assigns(:pelayanan_lain))
  end

  test "should destroy pelayanan_lain" do
    assert_difference('PelayananLain.count', -1) do
      delete :destroy, :id => @pelayanan_lain.to_param
    end

    assert_redirected_to pelayanan_lains_path
  end
end
