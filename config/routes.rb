# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'welcome#index'
  get 'z/index.html', to: redirect("/")
  
  get 'about' => 'welcome#about'
  get 'day_color', controller: 'day_color', action: 'day_color'
  get 'autocomplete', :to => 'application#autocomplete'

  resources :announcements, only: [:index, :show]
  resources :links, only: [:index]

  resources :departments, shallow: true do
    member do
      post :subscribe
      post :unsubscribe
    end
    resources :courses
  end

  namespace :admin do
    root :to => "base#index"

    post "/rankables/sort" => "rankables#sort", :as => :sort_rankable

    resources :announcements
    resources :links

    resources :departments, shallow: true, only: [:new, :create, :edit, :update, :destroy] do
      resources :courses
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

  resources :alerts do
    collection do
      post "read_all"
    end
  end
end
