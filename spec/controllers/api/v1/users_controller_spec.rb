require "rails_helper"
require "spec_helper"

RSpec.describe "UsersController", type: :request do
  include_context "shared context"

  describe "create" do
    subject { build(:user) }

    context "when a user logs in" do
      it "saves user and generates auth token" do
        post "/auth/login",
             email: subject.email,
             password: subject.password

        expect(response.status).to eql 201

        expect(json).not_to be_nil
        expect(User.last.email).to eql subject.email

      end
    end
  end

  describe "logout" do
    context "when a user logs out" do
      context "with an authorization token" do
        it "nullifies the token" do
          new_token = token
          get "/auth/logout", {}, HTTP_AUTHORIZATION: "token #{new_token}"

          expect(response.status).to eql 200
          expect(json[:message]).to eql "Logged out successfully"
          expect(User.find_by(token: new_token)).to be_nil
        end
      end

      context "without an authorization token" do
        it "is an authorized request" do
           get "/auth/logout"
           
           expect(response.status).to eql 401
           expect(json[:errors][:unauthorized]).not_to be_nil
        end
      end
    end
  end
end
