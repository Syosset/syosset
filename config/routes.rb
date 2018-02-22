Rails.application.routes.draw do
  # Main pages
  root 'welcome#index'
  get 'landing' => 'welcome#landing' # browser homepage on school devices
  get 'about' => 'welcome#about'
  get 'status' => 'welcome#status' # to check that app is alive upon deploy

  get 'z/index.html', to: redirect('/') # legacy endpoint -> still set on school devices (Syosset/syosset#83)

  # Authentication
  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'
  match '/auth/:provider/callback' => 'sessions#create', via: %i[get post]
  get '/auth/failure' => 'sessions#failure'

  # Users
  resources :users, only: %i[index new show edit update] do
    post :populate, on: :collection # create multiple users and assign to collaborator groups
    resources :periods, on: :member, except: [:show]

    scope module: 'users' do
      collection do
        resources :user_autocompletions, only: :index, controller: :autocompletions, path: :autocompletions
      end
    end

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
      post 'read_all'
    end
  end

  # Escalation Requests
  resources :escalation_requests, path: 'escalations' do
    post 'approve', action: :approve, as: :approve
    post 'deny', action: :deny, as: :deny
  end

  # Collaborator Groups
  resources :collaborator_groups, only: %i[edit update] do
    scope module: 'collaborator_groups' do
      resources :memberships, only: %i[create destroy]
    end
  end

  # Admin Panel
  resource :administration, only: :show do
    scope module: 'administration' do
      resource :privileges, only: %i[create destroy]
    end
  end

  # Day Color and Closures
  resource :day, only: %i[show edit update] do
    post 'fetch'
  end

  resources :closures

  # Promotions
  resources :promotions

  #  Badge Management
  resources :badges, except: [:show]

  # Integration Management
  resources :integrations do
    post :clear_failures, on: :member
  end

  # Message Threads
  get '/threads/create' => 'message_threads#create'
  get '/threads/:id/messages' => 'message_threads#read_messages'
  post '/threads/:id/messages' => 'message_threads#send_message'

  # Auditing
  resources :history_trackers, only: %i[index show]

  # Sortable AJAX
  post '/rankables/sort' => 'rankables#sort', :as => :sort_rankable

  # Attachments
  post '/attachments' => 'attachments#create'

  # Utilities
  mount Peek::Railtie => '/peek'
end
