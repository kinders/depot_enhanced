require 'test_helper'

class ShipsControllerTest < ActionController::TestCase
  setup do
    @ship = ships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ships)
  end

  test "should get new" do
    @order_id = line_items(:one).order_id
    get :new, order_id: @order_id
    assert_response :success
  end

  test "should create ship" do
    assert_difference('Ship.count') do
      post :create, ship: { express_company: @ship.express_company, express_number: @ship.express_number, is_receive: @ship.is_receive, order_id: @ship.order_id, send_date: @ship.send_date, sender: @ship.sender }
    end

    assert_redirected_to ship_path(assigns(:ship))
  end

  test "should show ship" do
    get :show, id: @ship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ship
    assert_response :success
  end

  test "should update ship" do
    patch :update, id: @ship, ship: { express_company: @ship.express_company, express_number: @ship.express_number, is_receive: @ship.is_receive, order_id: @ship.order_id, send_date: @ship.send_date, sender: @ship.sender }
    assert_redirected_to ship_path(assigns(:ship))
  end

  test "should destroy ship" do
    assert_difference('Ship.count', -1) do
      delete :destroy, id: @ship
    end

    assert_redirected_to ships_path
  end
end
