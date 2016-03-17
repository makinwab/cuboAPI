require "rails_helper"
require "spec_helper"

RSpec.describe "BucketsController", type: :request do
  include_context "shared context"

  describe "#index" do
    let(:new_token) { token }
    let(:bucketlist) { create(:bucket) }

    context "when retrieving a bucketlist" do
      it "is an invalid request without an authorization token" do
        get "/bucketlists"

        expect(response.status).to eql 401
        expect(json[:errors][:unauthorized]).not_to be_nil
      end

      context "when an authorization token is set" do
        context "when a limit and page number is passed" do
          it "paginates the bucketlists data" do
            post "/bucketlists", { name: "newbucket" },
                 HTTP_AUTHORIZATION: "token #{new_token}"
            get "/bucketlists?page=1&limit=2", {},
                HTTP_AUTHORIZATION: "token #{new_token}"

            expect(response.status).to eql 200
            expect(json.length).to eql 1
          end
        end

        context "when a search query is passed" do
          context "when result is found" do
            it "returns paginated bucketlists"\
            " data that match the search query" do
              q = "bucket"

              post "/bucketlists", { name: "newbucket" },
                   HTTP_AUTHORIZATION: "token #{new_token}"
              get "/bucketlists?q=#{q}", {},
                  HTTP_AUTHORIZATION: "token #{new_token}"

              expect(response.status).to eql 200
              expect(json.length).to eql 1
            end
          end

          context "when result is not found" do
            it "returns paginated bucketlists"\
            " data that match the search query" do
              q = "str"

              post "/bucketlists", { name: "another newbucket" },
                   HTTP_AUTHORIZATION: "token #{new_token}"
              get "/bucketlists?q=#{q}", {},
                  HTTP_AUTHORIZATION: "token #{new_token}"

              expect(response.status).to eql 200
              expect(json.length).to eql 0
              expect(json.empty?).to eql true
            end
          end
        end

        context "when a search query and limit is not passed" do
          it "returns paginated bucketlist with the defaults" do
            get "/bucketlists", {}, HTTP_AUTHORIZATION: "token #{token}"

            expect(response.status).to eql 200
            expect(json.length).not_to be_nil
          end
        end
      end
    end
  end

  describe "#create" do
    let(:new_token) { token }
    let(:bucketlist) { create(:bucket) }

    it "does not create bucket without authorization token" do
      post "/bucketlists", name: "newbucket3"

      expect(response.status).to eql 401
      expect(json[:errors][:unauthorized]).not_to be_nil
    end

    it "creates bucket with authorization token" do
      post "/bucketlists", { name: "newbucket" },
           HTTP_AUTHORIZATION: "token #{new_token}"

      expect(response.status).to eql 201
      expect(Bucket.all.count).to eql 1
    end
  end

  describe "#update" do
    let(:new_token) { token }
    let(:bucketlist) { create(:bucket) }

    it "updates a bucket with authorization header and bucket id" do
      put "/bucketlists/#{bucketlist[:id]}", { name: "updated bucket" },
          HTTP_AUTHORIZATION: "token #{new_token}"

      expect(response.status).to eql 201
      expect(Bucket.find_by(id: bucketlist[:id]).name).to eql "updated bucket"
    end
  end

  describe "#destroy" do
    let(:new_token) { token }
    let(:bucketlist) { create(:bucket) }

    context "when authorization token is not set" do
      it "does not delete the item" do
        delete "/bucketlists/#{bucketlist[:id]}"

        expect(response.status).to eql 401
        expect(json[:errors][:unauthorized]).not_to be_nil
      end
    end

    context "when authorization token is set" do
      it "deletes the item" do
        delete "/bucketlists/#{bucketlist[:id]}", {},
               HTTP_AUTHORIZATION: "token #{new_token}"

        expect(response.status).to eql 201
        expect(json[:message]).to eql "Bucketlist successfully deleted"
        expect(Bucket.find_by(id: bucketlist[:id])).to be_nil
      end
    end
  end
end
