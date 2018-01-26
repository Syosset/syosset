Rails.application.routes.draw do

  # Main pages
  root 'welcome#index'
  get 'landing' => 'welcome#landing' # browser homepage on school devices
  get 'about' => 'welcome#about'

  get 'z/index.html', to: redirect("/") # legacy endpoint -> still set on school devices (Syosset/syosset#83)

  # Users and Profiles
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }, skip: [:passwords]
  resources :users, only: [:index, :new, :show, :edit, :update] do
    post :populate, on: :collection # create multiple users and assign to collaborator groups
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

  resources :announcements
  resources :links, except: [:show]

  # Alerts
  resources :alerts do
    collection do
      post "read_all"
    end
  end

  # Escalation Requests
  resources :escalation_requests, path: 'escalations' do
    post "approve", action: :approve, as: :approve
    post "deny", action: :deny, as: :deny
  end

  # Collaborator Management
  resources :collaborator_groups, only: [:edit, :update] do
    post "add_collaborator", action: :add_collaborator, as: :add_collaborator
    post "remove_collaborator", action: :remove_collaborator, as: :remove_collaborator
  end

  # Admin Panel
  get 'admin' => 'admin#index'
  post 'admin/renew' => 'admin#renew'
  post 'admin/resign' => 'admin#resign'

  # Day Color and Closures
  resource :day, only: [:show, :edit, :update] do
    post 'fetch'
  end

  resources :closures

  # Promotions
  resources :promotions

  # Badge Management
  resources :badges, except: [:show]

  # Integration Management
  resources :integrations do
    post :clear_failures, on: :member
  end

  # Auditing
  resources :history_trackers, only: [:index, :show]

  # Autocomplete AJAX
  get 'autocomplete', :to => 'application#autocomplete'

  # Sortable AJAX
  post "/rankables/sort" => "rankables#sort", :as => :sort_rankable

  # Attachments
  post "/attachments" => "attachments#create"

  # Utilities
  mount Peek::Railtie => '/peek'

end
