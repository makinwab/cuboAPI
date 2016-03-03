class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user_from_token, only: :create

  def create
    user = user_exists(email: params[:email], password: params[:password])

    unless user
      create_new_user
    else
      get_existing_user user
    end
  end

  def logout
    @current_user.update(token: nil)
    render json: { message: "Logged out successfully" }, status: :ok
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
    render json: { token: user.token }, status: :ok
  end

  def generate_and_update_token(user)
    token = user.generate_token
    user.update(token: token)
  end
end
