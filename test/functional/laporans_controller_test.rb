require 'test_helper'

class LaporansControllerTest < ActionController::TestCase
  setup do
    @laporan = laporans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:laporans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create laporan" do
    assert_difference('Laporan.count') do
      post :create, :laporan => @laporan.attributes
    end

    assert_redirected_to laporan_path(assigns(:laporan))
  end

  test "should show laporan" do
    get :show, :id => @laporan.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @laporan.to_param
    assert_response :success
  end

  test "should update laporan" do
    put :update, :id => @laporan.to_param, :laporan => @laporan.attributes
    assert_redirected_to laporan_path(assigns(:laporan))
  end

  test "should destroy laporan" do
    assert_difference('Laporan.count', -1) do
      delete :destroy, :id => @laporan.to_param
    end

    assert_redirected_to laporans_path
  end
end
