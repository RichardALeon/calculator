Rails.application.routes.draw do
  get 'page/index'
  root 'page#index'

  get 'page/execute', to: 'page#execute'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
