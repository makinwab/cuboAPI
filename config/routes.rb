Rails.application.routes.draw do
  namespace :api, path: "" do
    namespace :v1, path: "" do
      root "home#index"
      post "/auth/login", to: 'users#create'
      get "/auth/logout", to: 'users#logout'
      resources :buckets, path: "bucketlists" do
        resources :items
      end
    end
  end
end
