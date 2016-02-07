require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "the index action returns back json of all items" do
    get :index

    assert_equal 200, response.status

    items = JSON.parse(response.body, symbolize_names: true)

    assert_equal 2, items.count
    assert_equal "MyStringTwo", items[0][:name]
    refute_empty items
  end
end
