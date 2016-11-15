Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  namespace :api, path: '/api', defaults: { format: :json } do
    resources :posts
  end
end
