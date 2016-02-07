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

  test "the create action should create an item" do
    assert_difference("Item.count", 1) do
      item_params = { item: { name: "Create application", bucket_id: 1 }, format: :json  }

      post :create, item_params
      item = JSON.parse(response.body, symbolize_names: true)
     
      assert_equal "Create application", item[:name]
      assert_equal 1, item[:bucket_id]
    end
  end
end
