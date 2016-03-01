Rails.application.routes.draw do
  namespace :api, path: "" do
    namespace :v1, path: "" do
      resources :users
      resources :buckets do
        resources :items
      end
    end
  end
end
