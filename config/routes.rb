Rails.application.routes.draw do

  # Main pages
  root 'welcome#index'
  get 'landing' => 'welcome#landing' # browser homepage on school devices
  get 'about' => 'welcome#about'

  # Users and Profiles
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }, skip: [:passwords]
  resources :users, only: [:show] do
    resources :periods, on: :member, except: [:show]
  end

  # User content
  resources :activities

  resources :departments, shallow: true do
    member do
      post :subscribe
      post :unsubscribe
    end
    resources :courses do
      member do
        post :subscribe
        post :unsubscribe
      end
    end
  end

  resources :announcements, :links

  # Alerts
  resources :alerts do
    collection do
      post "read_all"
    end
  end

  # Day Color
  resource :day, only: [:show, :edit, :update] do
    post 'fetch'
  end

  get 'day_color' => 'day#legacy_show' # legacy endpoint -> required by ryan's app

  # Autocomplete AJAX
  get 'autocomplete', :to => 'application#autocomplete'

  # Sortable AJAX
  post "/rankables/sort" => "rankables#sort", :as => :sort_rankable

  # Utilities
  mount Peek::Railtie => '/peek'

  # This namespace is slowly being removed
  # Please add new routes elsewhere
  namespace :admin do
    root :to => "base#index"
    post "/renew" => "base#renew"
    post "/resign" => "base#resign"

    #get "/color" => "color#edit"
    #post "/color" => "color#update"
    #post "/color_trigger_update" => "color#trigger_update"

    resources :users, only: [:index, :edit, :update]

    #post "/rankables/sort" => "rankables#sort", :as => :sort_rankable

    #resources :announcements
    #resources :links

    resources :activities do
      member do
        post :unlock
      end
    end

    resources :departments, shallow: true, only: [:new, :create, :edit, :update, :destroy] do
      resources :courses
    end

    resources :integrations do
      post :clear_failures, on: :member
    end

    resources :escalation_requests do
      post "approve", action: :approve, as: :approve
      post "deny", action: :deny, as: :deny
    end

    resources :collaborator_groups, only: [:edit, :update] do
      post "add_collaborator", action: :add_collaborator, as: :add_collaborator
      post "remove_collaborator", action: :remove_collaborator, as: :remove_collaborator
    end
  end
end
