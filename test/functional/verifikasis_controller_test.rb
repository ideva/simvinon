require 'test_helper'

class VerifikasisControllerTest < ActionController::TestCase
  setup do
    @verifikasi = verifikasis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:verifikasis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create verifikasi" do
    assert_difference('Verifikasi.count') do
      post :create, :verifikasi => @verifikasi.attributes
    end

    assert_redirected_to verifikasi_path(assigns(:verifikasi))
  end

  test "should show verifikasi" do
    get :show, :id => @verifikasi.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @verifikasi.to_param
    assert_response :success
  end

  test "should update verifikasi" do
    put :update, :id => @verifikasi.to_param, :verifikasi => @verifikasi.attributes
    assert_redirected_to verifikasi_path(assigns(:verifikasi))
  end

  test "should destroy verifikasi" do
    assert_difference('Verifikasi.count', -1) do
      delete :destroy, :id => @verifikasi.to_param
    end

    assert_redirected_to verifikasis_path
  end
end
