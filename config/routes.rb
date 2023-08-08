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
  resources :products, only: [:index]

  resources :categories, only: [:new, :create, :show]
  get 'home/about'
  root 'home#index'

end
