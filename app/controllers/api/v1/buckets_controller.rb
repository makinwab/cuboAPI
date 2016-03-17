module Api
  module V1
    class BucketsController < ApplicationController
      def index
        params[:id] = @current_user.id

        buckets = Bucket.search(params).paginate(params)
        render json: buckets, status: :ok
      end

      def create
        bucketlist = Bucket.new(buckets_params)
        bucketlist.user_id = @current_user.id

        if bucketlist.save
          render json: bucketlist, status: :created
        else
          respond_to_failure "Could not create bucket"
        end
      end

      def show
        bucketlist = bucketlist(params)

        render json: bucketlist, status: :ok
      end

      def update
        bucket = Bucket.find_by(id: params[:id])

        if bucket.update(buckets_params)
          render json: bucket, status: 201
        else
          respond_to_failure "Could not update bucket"
        end
      end

      def destroy
        bucketlist = bucketlist(params)

        if bucketlist.destroy
          render json: { message: "Bucketlist successfully deleted" },
                 status: 201
        else
          respond_to_failure "Could not delete bucket"
        end
      end

      private

      def buckets_params
        params.permit(:name)
      end

      def bucketlist(params)
        Bucket.find_by(id: params[:id])
      end

      def respond_to_failure(message, status = 501)
        render json: { error: message }, status: status
      end
    end
  end
end
