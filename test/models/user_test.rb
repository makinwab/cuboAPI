require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user is valid with a email, password and token" do
    doe = User.create(
      email: "makinwab@yahoo.com",
      password: "makinwab",
      token: "token_string"
    )

    assert doe.valid?
    refute doe.invalid?
  end

  test "a user is invalid without email, password or token" do
    first_doe = User.create(
      password: "makinwab",
      token: "token_string"
    )

    second_doe = User.create(
      email: "makinwab@yahoo.com",
      token: "token_string"
    )

    third_doe = User.create(
      email: "makinwab@yahoo.com",
      password: "password"
    )

    fourth_doe = User.create(
      email: nil,
      password: nil,
      token: nil
    )

    assert first_doe.invalid?
    refute first_doe.valid?

    assert second_doe.invalid?
    refute second_doe.valid?

    assert third_doe.invalid?
    refute third_doe.valid?

    assert fourth_doe.invalid?
    refute fourth_doe.valid?
  end
end
