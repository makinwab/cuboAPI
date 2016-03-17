require "rails_helper"
require "spec_helper"

RSpec.describe "ItemsController", type: :request do
  include_context "shared context"

  describe "#index" do
    let(:new_token) { token }
    let(:bucketlist) { create(:bucket) }
    let(:item) { create(:item) }

    context "when authorization token is not set" do
      it "does not get the items in a bucketlist" do
        get "/bucketlists/#{bucketlist[:id]}/items"

        expect(response.status).to eql 401
        expect(json[:errors][:unauthorized]).not_to be_nil
      end
    end

    context "when retrieving an item with an authorization token" do
      it "gets all items in the bucketlist" do
        post "/bucketlists/#{bucketlist[:id]}/items", { name: "newitem" },
             HTTP_AUTHORIZATION: "token #{new_token}"

        get "/bucketlists/#{bucketlist[:id]}/items", {},
            HTTP_AUTHORIZATION: "token #{new_token}"

        expect(response.status).to eql 200
        expect(json.length).to eql 1
      end
    end
  end

  describe "#create" do
    let(:new_token) { token }
    let(:bucketlist) { create(:bucket) }
    let(:item) { create(:item) }

    context "when authorization token is not set" do
      it "does not create item without authorization token" do
        post "/bucketlists/#{bucketlist[:id]}/items", name: "another new item"

        expect(response.status).to eql 401
        expect(json[:errors][:unauthorized]).not_to be_nil
      end
    end

    context "when authorization token is set" do
      it "creates item with authorization token" do
        post "/bucketlists/#{bucketlist[:id]}/items", { name: "newitem" },
             HTTP_AUTHORIZATION: "token #{new_token}"

        expect(response.status).to eql 201
        expect(Item.all.count).to eql 1
      end
    end
  end

  describe "#update" do
    let(:new_token) { token }
    let(:bucketlist) { create(:bucket) }
    let(:item) { create(:item) }

    context "when authorization token is not set" do
      it "does not update the item" do
        put "/bucketlists/#{bucketlist[:id]}/items/#{item[:id]}",
            name: "updated item"

        expect(response.status).to eql 401
        expect(json[:errors][:unauthorized]).not_to be_nil
      end
    end

    context "when authorization token is set" do
      it "updates the item" do
        put "/bucketlists/#{bucketlist[:id]}/items/#{item[:id]}",
            { name: "updated item" },
            HTTP_AUTHORIZATION: "token #{new_token}"

        expect(response.status).to eql 201
        expect(Item.find_by(id: item[:id]).name).to eql "updated item"
      end
    end
  end

  describe "#destroy" do
    let(:new_token) { token }
    let(:bucketlist) { create(:bucket) }
    let(:item) { create(:item) }

    context "when authorization token is not set" do
      it "does not delete the item" do
        delete "/bucketlists/#{bucketlist[:id]}/items/#{item[:id]}"

        expect(response.status).to eql 401
        expect(json[:errors][:unauthorized]).not_to be_nil
      end
    end

    context "when authorization token is set" do
      it "deletes the item" do
        delete "/bucketlists/#{bucketlist[:id]}/items/#{item[:id]}", {},
               HTTP_AUTHORIZATION: "token #{new_token}"

        expect(response.status).to eql 201
        expect(json[:message]).to eql "Item successfully deleted"
        expect(Item.find_by(id: item[:id])).to be_nil
      end
    end
  end
end
