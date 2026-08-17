Rails.application.routes.draw do
  get "/my-courses", to: "courses#my_courses", as: "my_courses"
  get "courses/list", to: "courses#index"
  get "courses/:id", to: "courses#show", constraints: { id: /\d+/ }
  get "courses/new", to: "courses#new"
  post "courses/:id/enroll", to: "courses#create_enrollment", constraints: { id: /\d+/ }, as: "courses_enroll"
  get "courses/:id/enroll", to: "courses#enroll", constraints: { id: /\d+/ }, as: "courses_invite_enroll"
  post "courses", to: "courses#create"

  get "/dashboard", to: "dashboard#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
