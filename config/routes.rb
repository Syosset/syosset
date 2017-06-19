# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  get 'day_color', controller: 'day_color', action: 'day_color'
end
