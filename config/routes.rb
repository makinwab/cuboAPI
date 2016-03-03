Rails.application.routes.draw do
  namespace :api, path: "" do
    namespace :v1, path: "" do
      post "/auth/login", to: 'users#create'
      get "/auth/logout", to: 'users#logout'
      resources :buckets do
        resources :items
      end
    end
  end
end
