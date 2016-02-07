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
end
