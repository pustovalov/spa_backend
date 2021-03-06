require 'api_constraints'

Rails.application.routes.draw do
  post 'log_in', to: 'user_token#login'
  post 'sign_up', to: 'user_token#sign_up'

  post 'settings', to: 'settings#index'
  post 'settings/edit', to: 'settings#edit'

  namespace :api, path: '/api', defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :posts
    end
    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: true) do
      resources :posts
    end
  end
end
