require 'test_helper'

class KategoriTindakanMedisControllerTest < ActionController::TestCase
  setup do
    @kategori_tindakan_medi = kategori_tindakan_medis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kategori_tindakan_medis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kategori_tindakan_medi" do
    assert_difference('KategoriTindakanMedi.count') do
      post :create, :kategori_tindakan_medi => @kategori_tindakan_medi.attributes
    end

    assert_redirected_to kategori_tindakan_medi_path(assigns(:kategori_tindakan_medi))
  end

  test "should show kategori_tindakan_medi" do
    get :show, :id => @kategori_tindakan_medi.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @kategori_tindakan_medi.to_param
    assert_response :success
  end

  test "should update kategori_tindakan_medi" do
    put :update, :id => @kategori_tindakan_medi.to_param, :kategori_tindakan_medi => @kategori_tindakan_medi.attributes
    assert_redirected_to kategori_tindakan_medi_path(assigns(:kategori_tindakan_medi))
  end

  test "should destroy kategori_tindakan_medi" do
    assert_difference('KategoriTindakanMedi.count', -1) do
      delete :destroy, :id => @kategori_tindakan_medi.to_param
    end

    assert_redirected_to kategori_tindakan_medis_path
  end
end
