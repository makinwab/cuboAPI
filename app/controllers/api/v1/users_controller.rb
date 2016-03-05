module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user_from_token, only: :create

      def create
        user = user_exists(email: params[:email], password: params[:password])

        if user
          get_existing_user user
        else
          create_new_user
        end
      end

      def logout
        if @current_user.update_attributes(token: nil)
          render json: { message: "Logged out successfully" }, status: :ok
        else
          render json: { error: "Logout was not successful" }, status: 501
        end
      end

      private

      def users_params
        params.permit(:email, :password)
      end

      def user_exists(options)
        User.find_by(options)
      end

      def create_new_user
        user = User.new(users_params)

        if user.save
          generate_and_update_token user
          render json: { token: user.token },
                 status: :created
        end
      end

      def get_existing_user(user)
        generate_and_update_token user
        render json: { token: user.token }, status: 201
      end

      def generate_and_update_token(user)
        token = user.generate_token
        user.update_attributes(token: token)
      end
    end
  end
end
