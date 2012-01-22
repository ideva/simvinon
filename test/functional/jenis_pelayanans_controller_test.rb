require 'test_helper'

class JenisPelayanansControllerTest < ActionController::TestCase
  setup do
    @jenis_pelayanan = jenis_pelayanans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jenis_pelayanans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jenis_pelayanan" do
    assert_difference('JenisPelayanan.count') do
      post :create, :jenis_pelayanan => @jenis_pelayanan.attributes
    end

    assert_redirected_to jenis_pelayanan_path(assigns(:jenis_pelayanan))
  end

  test "should show jenis_pelayanan" do
    get :show, :id => @jenis_pelayanan.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @jenis_pelayanan.to_param
    assert_response :success
  end

  test "should update jenis_pelayanan" do
    put :update, :id => @jenis_pelayanan.to_param, :jenis_pelayanan => @jenis_pelayanan.attributes
    assert_redirected_to jenis_pelayanan_path(assigns(:jenis_pelayanan))
  end

  test "should destroy jenis_pelayanan" do
    assert_difference('JenisPelayanan.count', -1) do
      delete :destroy, :id => @jenis_pelayanan.to_param
    end

    assert_redirected_to jenis_pelayanans_path
  end
end
