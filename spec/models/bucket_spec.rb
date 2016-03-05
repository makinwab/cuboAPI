require "rails_helper"
require "spec_helper"

RSpec.describe Bucket, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :user_id }
  it { should belong_to :user }
  it { should have_many :items }
end
