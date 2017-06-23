# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'welcome#index'
  get 'about' => 'welcome#about'

  get 'day_color', controller: 'day_color', action: 'day_color'
end
