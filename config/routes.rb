# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'welcome#index'
  get 'about' => 'welcome#about'

  get 'day_color', controller: 'day_color', action: 'day_color'

  resources :departments, shallow: true do
    member do
      post :subscribe
      post :unsubscribe
    end
  end
  
  get 'autocomplete', :to => 'application#autocomplete'

  namespace :admin do
    root :to => "base#index"
    resources :departments, shallow: true, only: [:new, :create, :edit, :update, :destroy]
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
