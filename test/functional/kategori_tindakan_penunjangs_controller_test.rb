require 'test_helper'

class KategoriTindakanPenunjangsControllerTest < ActionController::TestCase
  setup do
    @kategori_tindakan_penunjang = kategori_tindakan_penunjangs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kategori_tindakan_penunjangs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kategori_tindakan_penunjang" do
    assert_difference('KategoriTindakanPenunjang.count') do
      post :create, :kategori_tindakan_penunjang => @kategori_tindakan_penunjang.attributes
    end

    assert_redirected_to kategori_tindakan_penunjang_path(assigns(:kategori_tindakan_penunjang))
  end

  test "should show kategori_tindakan_penunjang" do
    get :show, :id => @kategori_tindakan_penunjang.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @kategori_tindakan_penunjang.to_param
    assert_response :success
  end

  test "should update kategori_tindakan_penunjang" do
    put :update, :id => @kategori_tindakan_penunjang.to_param, :kategori_tindakan_penunjang => @kategori_tindakan_penunjang.attributes
    assert_redirected_to kategori_tindakan_penunjang_path(assigns(:kategori_tindakan_penunjang))
  end

  test "should destroy kategori_tindakan_penunjang" do
    assert_difference('KategoriTindakanPenunjang.count', -1) do
      delete :destroy, :id => @kategori_tindakan_penunjang.to_param
    end

    assert_redirected_to kategori_tindakan_penunjangs_path
  end
end
