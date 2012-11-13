Minicontest::Application.routes.draw do
  root to: 'session#show'
  authpwn_session

  resources :users, only: [:new, :create, :show]
  resources :submissions, only: [:index, :new, :create]

  ActiveAdmin.routes(self)
end
