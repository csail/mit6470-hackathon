Minicontest::Application.routes.draw do
  root to: 'session#show'
  authpwn_session

  resources :users, only: [:new, :create, :show]
  resources :submissions, only: [:index, :new, :create]
  resources :scores, only: [:index]
  resources :verdicts, only: [:show] do
    member { get :endpoint_response }
  end

  ActiveAdmin.routes(self)
end
