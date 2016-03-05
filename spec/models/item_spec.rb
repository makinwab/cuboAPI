require "rails_helper"
require "spec_helper"

RSpec.describe Item, type: :model do
  it { should validate_presence_of :name }
  it { should belong_to :bucket }
end
