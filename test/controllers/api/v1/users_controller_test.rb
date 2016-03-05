require "test_helper"

class Api::V1::UsersControllerTest < ActionController::TestCase
  test "the create action should create a user and generate a token" do
    assert_difference("User.count", 1) do
      create_params = {
        email: "maba@gmail.com",
        password: "maba"
      }

      post "create", create_params

      assert_equal 201, response.status
      user = JSON.parse(response.body, symbolize_names: true)

      assert_not_nil user[:token]
    end
  end
end
