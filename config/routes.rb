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

  root to: 'products#index'
  devise_for :users
  resources :users
  resources :products
  get 'manage-products' => 'products#manage'
  resources :carts
  get 'cart' => 'carts#show'
  resources :cart_items
  post 'addtocart' => 'cart_items#add_to_cart'
  resources :orders do
    get :checkout, on: :collection, as: :checkout
  end
  get 'manage-orders' => 'orders#index_all'
  resources :order_items
end
