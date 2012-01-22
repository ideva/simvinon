require 'test_helper'

class PesertaJkbmsControllerTest < ActionController::TestCase
  setup do
    @peserta_jkbm = peserta_jkbms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:peserta_jkbms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create peserta_jkbm" do
    assert_difference('PesertaJkbm.count') do
      post :create, :peserta_jkbm => @peserta_jkbm.attributes
    end

    assert_redirected_to peserta_jkbm_path(assigns(:peserta_jkbm))
  end

  test "should show peserta_jkbm" do
    get :show, :id => @peserta_jkbm.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @peserta_jkbm.to_param
    assert_response :success
  end

  test "should update peserta_jkbm" do
    put :update, :id => @peserta_jkbm.to_param, :peserta_jkbm => @peserta_jkbm.attributes
    assert_redirected_to peserta_jkbm_path(assigns(:peserta_jkbm))
  end

  test "should destroy peserta_jkbm" do
    assert_difference('PesertaJkbm.count', -1) do
      delete :destroy, :id => @peserta_jkbm.to_param
    end

    assert_redirected_to peserta_jkbms_path
  end
end
