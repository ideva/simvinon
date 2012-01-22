require 'test_helper'

class TindakanPenunjangsControllerTest < ActionController::TestCase
  setup do
    @tindakan_penunjang = tindakan_penunjangs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tindakan_penunjangs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tindakan_penunjang" do
    assert_difference('TindakanPenunjang.count') do
      post :create, :tindakan_penunjang => @tindakan_penunjang.attributes
    end

    assert_redirected_to tindakan_penunjang_path(assigns(:tindakan_penunjang))
  end

  test "should show tindakan_penunjang" do
    get :show, :id => @tindakan_penunjang.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @tindakan_penunjang.to_param
    assert_response :success
  end

  test "should update tindakan_penunjang" do
    put :update, :id => @tindakan_penunjang.to_param, :tindakan_penunjang => @tindakan_penunjang.attributes
    assert_redirected_to tindakan_penunjang_path(assigns(:tindakan_penunjang))
  end

  test "should destroy tindakan_penunjang" do
    assert_difference('TindakanPenunjang.count', -1) do
      delete :destroy, :id => @tindakan_penunjang.to_param
    end

    assert_redirected_to tindakan_penunjangs_path
  end
end
