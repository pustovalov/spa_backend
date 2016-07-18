Rails.application.routes.draw do
  namespace :api, path: '/api', defaults: { format: :json } do
    resources :posts
  end
end
