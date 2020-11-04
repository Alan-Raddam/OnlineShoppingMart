Rails.application.routes.draw do
  resources :blogs do
    resources :comments
  end
  root 'blogs#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
