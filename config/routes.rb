Rails.application.routes.draw do


  post '/process_checkout', to: 'carts#process_checkout', as: :process_checkout_cart


  get 'checkout', to: 'carts#checkout', as: :checkout
  resources :orders, only: :create

  put '/carts/update_quantity', to: 'carts#update_quantity', as: :update_quantity_carts
  delete 'carts/remove_from_cart', to: 'carts#remove_from_cart', as: :remove_from_cart




  post 'add_to_cart', to: 'carts#add_to_cart', as: :add_to_cart
  get 'show_cart', to: 'carts#show_cart', as: :show_cart
  devise_for :users

  resources :carts, only: [] do
    post 'process_checkout', on: :collection
    post 'checkout', on: :collection
    get 'checkout', on: :member
    get :show_cart, on: :collection
    post :update_quantity, on: :collection
    collection do
      delete 'remove_from_cart'
    end
  end

  resources :products do
   get :search, on: :collection
    collection do
      get 'on_sale'
      get 'new_products'
      get 'recently_updated_products'
    end
  end

  resources :categories do
    resources :products
  end
  resources :products, only: [:new, :create]
  resources :categories, only: [:new, :create, :show]
  get 'home/about'
  root 'home#index'

end
