module Api
  module V1
    class HomeController < ApplicationController
      skip_before_action :authenticate_user_from_token

      def index
        redirect_to "http://docs.cuboapi.apiary.io/#"
      end
    end
  end
end
