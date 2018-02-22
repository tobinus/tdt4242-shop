Rails.application.routes.draw do

  namespace :admin do
    resources :users
    resources :products
    resources :carts
    resources :cart_items
    resources :orders
    resources :order_items
    root to: "users#index"
  end

  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :products
  get 'manageproducts' => 'products#manage'
  resources :carts
  get 'cart' => 'carts#show'
  resources :cart_items
  post 'addtocart' => 'cart_items#add_to_cart'
  resources :orders
  resources :order_items
end
