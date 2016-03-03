require "test_helper"

class Api::V1::ItemsControllerTest < ActionController::TestCase
  doe = User.create(
    email: "makinwab@yahoo.com",
    password: "makinwab"
  )

  my_bucket = Bucket.create(name: "bootcamp", user_id: doe.id)

  test "the index action returns back all the items in a bucket" do
    get :index, bucket_id: 1

    assert_equal 200, response.status

    items = JSON.parse(response.body, symbolize_names: true)

    assert_response :success

    assert_equal 2, Item.all.count
    assert_equal "MyStringTwo", items[:name]
    refute_empty items
  end

  test "the create action should create an item" do
    assert_difference("Item.count", 1) do
      item_params = { item: {
        name: "Create application",
        bucket_id: my_bucket.id },
                      bucket_id: my_bucket.id,
                      format: :json
      }

      post :create, item_params
      item = JSON.parse(response.body, symbolize_names: true)

      assert_equal my_bucket.id, item[:bucket_id]
    end
  end
end
