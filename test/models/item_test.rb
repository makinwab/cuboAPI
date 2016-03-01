require "test_helper"

class ItemTest < ActiveSupport::TestCase
  doe = User.create(
      email: "makinwab@yahoo.com",
      password: "makinwab",
      token: "token_string"
    )

  my_bucket = Bucket.create(name: "bootcamp", user_id: doe.id)

  my_first_task = Item.create(
      name: "read bootcamp document",
      bucket_id: my_bucket.id
    )

  test "an item is valid with a name and bucket_id" do
    assert my_first_task.valid?
    refute my_first_task.invalid?
  end

  test "an item is invalid without a name and bucket_id" do
    my_first_task = Item.create(name: "read bootcamp document", bucket_id: nil)
    my_second_task = Item.create(name: nil, bucket_id: my_bucket.id)
    my_third_task = Item.create(name: nil, bucket_id: nil)

    assert my_first_task.invalid?
    refute my_first_task.valid?

    assert my_second_task.invalid?
    refute my_second_task.valid?

    assert my_third_task.invalid?
    refute my_third_task.valid?
  end

  test "a bucket has items" do
    #assert_equal 1, my_bucket.items.count

    assert_equal my_first_task[:name],
                 my_bucket.items.find(my_first_task.id).name
  end
end
