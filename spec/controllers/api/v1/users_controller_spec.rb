require "rails_helper"
require "spec_helper"

RSpec.describe "UsersController", type: :request do
  describe "create" do
    subject { build(:user) }

    context "when logging a user in" do
      it "signs user in and generates auth token" do
        post "/auth/login",
             email: subject.email,
             password: subject.password

        expect(response.status).to eql 201
        token = JSON.parse(response.body, symbolize_names: true)

        expect(token).not_to be_nil
      end
    end
  end
end
