# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'welcome#index'
  get 'about' => 'welcome#about'

  get 'day_color', controller: 'day_color', action: 'day_color'

  resources :departments, shallow: true

  namespace :admin do
    root :to => "base#index"
    resources :departments, shallow: true, only: [:new, :create, :edit, :update, :destroy]
    resources :collaborator_groups, only: [:edit, :update] do
      # TODO patch adding members and removing members
    end
  end

  resources :alerts do
    collection do
      post "read_all"
    end
  end
end
