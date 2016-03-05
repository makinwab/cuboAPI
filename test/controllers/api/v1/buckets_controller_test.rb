require "test_helper"

class Api::V1::BucketsControllerTest < ActionController::TestCase
  test "the index action returns back json of all buckets" do
    @current_user = { id: 1 }
    get :index

    assert_equal 200, response.status

    buckets = JSON.parse(response.body, symbolize_names: true)

    assert_equal 2, buckets.count
    assert_equal "MyString", buckets[1][:name]
    refute_empty buckets
  end

  test "the create action should create a bucket" do
    bucket_params = { name: "Todo List" }
    post :create, bucket_params

    assert_equal 201, response.status
    bucketlist = JSON.parse(response.body, symbolize_names: true)

    assert_equal "Todo List", bucketlist[:name]
    assert_equal 1, bucketlist[:user_id]
  end

  test "the show action should show a bucket list" do
    my_bucket = Bucket.create(name: "High level tasks")

    get :show, id: my_bucket.id

    assert_equal 200, response.status

    bucketlist = JSON.parse(response.body, symbolize_names: true)

    assert_equal "High level tasks", bucketlist[:name]
    refute_empty Bucket.all
    assert_equal 1, bucketlist[:user_id]
  end
end
