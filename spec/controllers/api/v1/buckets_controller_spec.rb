require "rails_helper"
require "spec_helper"

RSpec.describe "BucketsController", type: :request do
  include_context "shared context"

  describe "#index" do
    let(:new_token) { token }

    context "when retrieving a bucketlist" do
      it "is an invalid request without an authorization token" do
        get "/bucketlists"

        expect(response.status).to eql 401
        expect(json[:errors][:unauthorized]).not_to be_nil
      end

      context "when an authorization token is set" do
        context "when a limit and page number is passed" do
          it "paginates the bucketlists data" do

            get "/bucketlists?page=1&limit=4", {}, HTTP_AUTHORIZATION: "token #{new_token}"
            
            expect(response.status).to eql 200
            expect(json.length).to eql 2
          end
        end

        context "when a search query is passed" do
          it "returns paginated bucketlists data that match the search query" do
            q = "string"
            get "/bucketlists?q=#{q}", {}, HTTP_AUTHORIZATION: "token #{new_token}"

            expect(response.status).to eql 200
            #binding.pry
            #expect(json.length).to eql 1
            #expect(json[:name].downcase).to include "MyStr"
          end
        end

        context "when a search query and limit is not passed" do
          it "returns bucketlists data paginated with the default limit and offset" do
            get "/bucketlists", {}, HTTP_AUTHORIZATION: "token #{token}"
            
            expect(response.status).to eql 200
            expect(json.length).not_to eql 1
          end
        end
      end
    end
  end

  describe "#create" do
    let(:new_token) { token }

    it "does not create bucket without authorization token" do
      post "/bucketlists", { name: "newbucket3" }

      expect(response.status).to eql 401
      expect(Bucket.all.count).to eql 2
      expect(json[:errors][:unauthorized]).not_to be_nil
    end

    it "creates bucket with authorization token" do
      post "/bucketlists", { name: "newbucket" }, HTTP_AUTHORIZATION: "token #{new_token}"

      expect(response.status).to eql 201
      expect(Bucket.all.count).to eql 3
    end
  end

  describe "#update" do
    let(:new_token) { token }

    it "updates a bucket with authorization header and bucket id" do

      put "/bucketlists/980190962", { name: "updated bucket" }, HTTP_AUTHORIZATION: "token #{new_token}"
     
      expect(response.status).to eql 201
      expect(Bucket.find_by(id: 980190962).name).to eql "updated bucket"
    end
  end
end
