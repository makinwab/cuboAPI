require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "the index action returns back json of all users" do
    get :index

    assert_equal 200, response.status

    users = JSON.parse(response.body, symbolize_names: true)
    
    assert_equal 3, users.count
    assert_equal "abc@gmail.com", users[0][:email]
  end

  test "the create action should create a user" do
    assert_difference("User.count", 1) do
      create_params = { user: { email: "maba@gmail.com", password: "maba", token: "tokenstring" }, format: :json }
      post 'create', create_params

      assert_equal 201, response.status
      user = JSON.parse(response.body, symbolize_names: true)

      assert_equal "maba@gmail.com", user[:email]
    end
  end
end
