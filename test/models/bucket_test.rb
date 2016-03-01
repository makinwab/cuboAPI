require "test_helper"

class BucketTest < ActiveSupport::TestCase
  doe = User.create(
      email: "makinwab@yahoo.com",
      password: "makinwab",
      token: "token_string"
    )
  my_bucket = Bucket.create(name: "bootcamp", user_id: doe.id)

  test "a bucket is valid with a name and user id" do
    assert my_bucket.valid?
    refute my_bucket.invalid?
  end

  test "a bucket is invalid without a name and user id" do
  
    my_first_bucket = Bucket.create(name: "bootcamp")
    my_second_bucket = Bucket.create(user_id: doe.id)
    my_third_bucket = Bucket.create(name: nil, user_id: nil)

    assert my_first_bucket.invalid?
    refute my_first_bucket.valid?

    assert my_second_bucket.invalid?
    refute my_second_bucket.valid?

    assert my_third_bucket.invalid?
    refute my_third_bucket.valid?
  end

  test "a user can assess his bucket" do
    assert_equal 1, doe.buckets.count
    assert_equal my_bucket.name, doe.buckets.find_by(id: my_bucket.id).name
  end
end
