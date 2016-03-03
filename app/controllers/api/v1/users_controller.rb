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
    user.token = user.generate_token

    if user.save
      token = user.generate_token
      user.update(token: token)
      render json: { token: user.token },
             status: :created
    end
  end

  def get_existing_user(user)
    render json: { token: user.token }, status: :ok
  end
end
