Rails.application.routes.draw do
  resources :products do
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
  resources :products
  resources :categories, only: [:new, :create, :show]
  get 'home/about'
  root 'home#index'
  get '/products/on_sale', to: 'products#on_sale', as: 'on_sale_products'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
