require 'test_helper'

class Api::V1::BucketsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "the index action returns back json of all buckets" do
    get :index

    assert_equal 200, response.status

    buckets = JSON.parse(response.body, symbolize_names: true)

    assert_equal 2, buckets.count
    assert_equal "MyString", buckets[1][:name]
    refute_empty buckets
  end

  test "the create action should create a bucket" do
    assert_difference("Bucket.count", 1) do
      bucket_params = { bucket: { name: "Todo List", user_id: 1 }, format: :json }

      post :create, bucket_params
      
      bucketlist = JSON.parse(response.body, symbolize_names: true)

      assert_equal "Todo List", bucketlist[:name]
      assert_equal 1, bucketlist[:user_id]
    end
  end
end
