Rails.application.routes.draw do
  resources :tools, except: [:delete] do
    resources :tool_assessments, only: [:new, :create]
    resources :tool_dependencies, only: [:new, :create]
    resources :tool_notes, only: [:new, :create]
    resources :tool_people, only: [:new, :create]
    resources :tool_technologies, only: [:new, :create]
    resources :tool_users, only: [:new, :create]
  end

  resources :person_orgs, except: [:delete]
  resources :tool_assessments, only: [:edit, :update]
  resources :tool_dependencies, only: [:edit, :update]
  resources :tool_notes, only: [:edit, :update]
  resources :tool_people, only: [:edit, :update]
  resources :tool_technologies, only: [:edit, :update]
  resources :tool_users, only: [:edit, :update]

  root 'tools#index'
end
