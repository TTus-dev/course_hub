Rails.application.routes.draw do
  root "sessions#new"

  get "my-courses", to: "courses#my_courses", as: "my_courses" # Enrolled or owned courses

  # Enrolled or owned courses (archived)
  get "my-archived-courses", to: "courses#my_archived_courses", as: "my_archived_courses"

  get "courses/list", to: "courses#index" # All courses
  get "courses/:id", to: "courses#show", constraints: { id: /\d+/ }, as: "courses_show" # Course details
  get "courses/new", to: "courses#new" # New course page

  # Enrollment without invite code
  post "courses/:id/enroll", to: "courses#create_enrollment", constraints: { id: /\d+/ }, as: "courses_enroll"

  # Enrollment with invite code
  get "courses/:id/enroll", to: "courses#enroll", constraints: { id: /\d+/ }, as: "courses_invite_enroll"

  # Leave course
  delete "courses/:id/leave", to: "courses#leave_course", constraints: { id: /\d+/ }, as: "courses_leave"

  # Create new course
  post "courses", to: "courses#create"

  # Archive instead of delete
  delete "courses/:id", to: "courses#archive", constraints: { id: /\d+/ }, as: "courses_archive"

  patch "courses/reactivate/:id", to: "courses#reactivate", constraints: { id: /\d+/ }, as: "courses_reactivate"

  get "courses/manage/:id", to: "courses#manage", as: "courses_manage" # Course edit page
  patch "courses/:id", to: "courses#update", constraints: { id: /\d+/ }, as: "courses_update" # Update details

  get "class_session/:id", to: "class_sessions#show", constraints: { id: /\d+/ }, as: "class_session"
  get "class_session/:id/edit", to: "class_sessions#edit", constraints: { id: /\d+/ }, as: "edit_class_session"
  get "class_session/new", to: "class_sessions#new", as: "new_class_session"
  post "class_session", to: "class_sessions#create", as: "class_sessions_create"
  patch "class_session/:id", to: "class_sessions#update", constraints: { id: /\d+/ }, as: "class_session_update"
  delete "class_session/:id", to: "class_sessions#destroy", constraints: { id: /\d+/ }, as: "class_session_destroy"

  get "/dashboard", to: "dashboard#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/register", to: "users#new"
  post "/register", to: "users#create"
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
