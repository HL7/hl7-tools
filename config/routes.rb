Rails.application.routes.draw do
  resources :tools, except: [:delete] do
    resources :tool_assessments, only: [:new, :create]
    resources :tool_dependencies, only: [:new, :create, :update]
    resources :tool_notes, only: [:new, :create, :update]
    resources :tool_people, only: [:new, :create, :update]
    resources :tool_technologies, only: [:new, :create, :update]
    resources :tool_users, only: [:new, :create, :update]
  end

  resources :person_orgs, except: [:delete]
  resources :tool_dependencies, only: [:edit]
  resources :tool_notes, only: [:edit]
  resources :tool_people, only: [:edit]
  resources :tool_technologies, only: [:edit]
  resources :tool_users, only: [:edit]

  root 'tools#index'
end
