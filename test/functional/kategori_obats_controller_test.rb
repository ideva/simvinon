require 'test_helper'

class KategoriObatsControllerTest < ActionController::TestCase
  setup do
    @kategori_obat = kategori_obats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kategori_obats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kategori_obat" do
    assert_difference('KategoriObat.count') do
      post :create, :kategori_obat => @kategori_obat.attributes
    end

    assert_redirected_to kategori_obat_path(assigns(:kategori_obat))
  end

  test "should show kategori_obat" do
    get :show, :id => @kategori_obat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @kategori_obat.to_param
    assert_response :success
  end

  test "should update kategori_obat" do
    put :update, :id => @kategori_obat.to_param, :kategori_obat => @kategori_obat.attributes
    assert_redirected_to kategori_obat_path(assigns(:kategori_obat))
  end

  test "should destroy kategori_obat" do
    assert_difference('KategoriObat.count', -1) do
      delete :destroy, :id => @kategori_obat.to_param
    end

    assert_redirected_to kategori_obats_path
  end
end
