class Api::V1::BucketsController < ApplicationController
  def index
    render json: Bucket.all, status: :ok
  end
end
