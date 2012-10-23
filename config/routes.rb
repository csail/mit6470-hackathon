Jampatch::Application.routes.draw do
  resources :users do
    get :autocomplete_users_region, :on => :collection
  end

  root :to => 'home#index'

  get "/test" => 'home#test'

  get "/login" => "login#index"
  get "/register" => "login#register"
  post "/submit_login" => "login#submit_login"
  post "/submit_logout" => "login#submit_logout"
  post "/submit_registration" => "login#submit_registration"
  get "/account/:user_id" => "login#user"

  post "/edit_email" => "login#edit_email"
  post "/edit_name" => "login#edit_name"
  post "/edit_region" => "login#edit_region"
  post "/edit_password" => "login#edit_password"
end
