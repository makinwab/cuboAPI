# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Bucket.destroy_all
Item.destroy_all

User.create(
  email: "makinwab@yahoo.com",
  password: "makinwab",
  token: "token_string"
)

3.times do |_n|
  User.create(email: Faker::Internet.email, password: Faker::Internet.password, token: Faker::Code.ean)
end

10.times do |_o|
  Bucket.create(name: Faker::Lorem.word, user_id: User.all.ids.sample)
end

5.times do |_j|
  Item.create(name: Faker::Lorem.word, bucket_id: Bucket.all.ids.sample)
end

print "Data seeded successfully"
