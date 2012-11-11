Minicontest::Application.routes.draw do
  root :to => 'home#index'

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

  get "/problems/:problem_id" => "problems#single"
  post "/submit_solution" => "problems#submit_solution"

  get "/create_problem" => "problems#create"
  post "/submit_problem" => "problems#submit_problem"
end
