Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "devise_customed/registrations"}
  resources :users
  root 'products#index'
  resources :favorites
  resources :transaction_items
  resources :transaction_orders
  resources :cartitems
  resources :sizes
  get 'products/remove_picture', to: 'products#remove_picture'
  resources :products
  get 'all', to: "products#inspect", as: "inspect_all"
  resources :colors
  resources :product_types
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'admin', to: 'admin#show'
  get 'test', to: 'admin#test'
  get 'transaction_orders/:id/adminedit', to: 'transaction_orders#adminedit', as: "admin_edit_transaction_orders"
  get 'transaction_orders/:id/receive_product', to: 'transaction_orders#receive_product', as: "receive_product"
  match 'favorites/remove', to: 'favorites#destroy', as: "remove_product_favorites", via: :post
  match 'favorites/reverse', to: 'favorites#reverse', via: :post
  match 'users/:id/change_password', to: 'users#change_password', via: :post, as: "change_password"
  match 'api/getmoney',to:"transaction_orders#setpaid", via: :get, as:"receive_money"
end
