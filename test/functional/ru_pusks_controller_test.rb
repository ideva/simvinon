require 'test_helper'

class RuPusksControllerTest < ActionController::TestCase
  setup do
    @ru_pusk = ru_pusks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ru_pusks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ru_pusk" do
    assert_difference('RuPusk.count') do
      post :create, :ru_pusk => @ru_pusk.attributes
    end

    assert_redirected_to ru_pusk_path(assigns(:ru_pusk))
  end

  test "should show ru_pusk" do
    get :show, :id => @ru_pusk.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ru_pusk.to_param
    assert_response :success
  end

  test "should update ru_pusk" do
    put :update, :id => @ru_pusk.to_param, :ru_pusk => @ru_pusk.attributes
    assert_redirected_to ru_pusk_path(assigns(:ru_pusk))
  end

  test "should destroy ru_pusk" do
    assert_difference('RuPusk.count', -1) do
      delete :destroy, :id => @ru_pusk.to_param
    end

    assert_redirected_to ru_pusks_path
  end
end
