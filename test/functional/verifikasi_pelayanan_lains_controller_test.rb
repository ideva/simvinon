require 'test_helper'

class VerifikasiPelayananLainsControllerTest < ActionController::TestCase
  setup do
    @verifikasi_pelayanan_lain = verifikasi_pelayanan_lains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:verifikasi_pelayanan_lains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create verifikasi_pelayanan_lain" do
    assert_difference('VerifikasiPelayananLain.count') do
      post :create, :verifikasi_pelayanan_lain => @verifikasi_pelayanan_lain.attributes
    end

    assert_redirected_to verifikasi_pelayanan_lain_path(assigns(:verifikasi_pelayanan_lain))
  end

  test "should show verifikasi_pelayanan_lain" do
    get :show, :id => @verifikasi_pelayanan_lain.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @verifikasi_pelayanan_lain.to_param
    assert_response :success
  end

  test "should update verifikasi_pelayanan_lain" do
    put :update, :id => @verifikasi_pelayanan_lain.to_param, :verifikasi_pelayanan_lain => @verifikasi_pelayanan_lain.attributes
    assert_redirected_to verifikasi_pelayanan_lain_path(assigns(:verifikasi_pelayanan_lain))
  end

  test "should destroy verifikasi_pelayanan_lain" do
    assert_difference('VerifikasiPelayananLain.count', -1) do
      delete :destroy, :id => @verifikasi_pelayanan_lain.to_param
    end

    assert_redirected_to verifikasi_pelayanan_lains_path
  end
end
