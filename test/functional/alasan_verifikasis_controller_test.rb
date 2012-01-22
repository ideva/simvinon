require 'test_helper'

class AlasanVerifikasisControllerTest < ActionController::TestCase
  setup do
    @alasan_verifikasi = alasan_verifikasis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alasan_verifikasis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alasan_verifikasi" do
    assert_difference('AlasanVerifikasi.count') do
      post :create, :alasan_verifikasi => @alasan_verifikasi.attributes
    end

    assert_redirected_to alasan_verifikasi_path(assigns(:alasan_verifikasi))
  end

  test "should show alasan_verifikasi" do
    get :show, :id => @alasan_verifikasi.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @alasan_verifikasi.to_param
    assert_response :success
  end

  test "should update alasan_verifikasi" do
    put :update, :id => @alasan_verifikasi.to_param, :alasan_verifikasi => @alasan_verifikasi.attributes
    assert_redirected_to alasan_verifikasi_path(assigns(:alasan_verifikasi))
  end

  test "should destroy alasan_verifikasi" do
    assert_difference('AlasanVerifikasi.count', -1) do
      delete :destroy, :id => @alasan_verifikasi.to_param
    end

    assert_redirected_to alasan_verifikasis_path
  end
end
