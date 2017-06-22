# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'welcome#index'
  get 'about' => 'welcome#about'

  get 'day_color', controller: 'day_color', action: 'day_color'
end
