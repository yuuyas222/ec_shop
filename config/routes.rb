Rails.application.routes.draw do
   
  

  scope module: :customers do
    #顧客トップページのルートパス
    root 'homes#top'
    #顧客の商品関連
    resources :products, only: [:index, :show]
    #カート内商品
    resources :cart_products, only: [:index, :create, :update, :destroy]
    delete 'cart_products' => 'cart_products#empty', as: :empty
    #顧客の注文関連
    post 'orders/confirm' => 'orders#confirm', as: :orders_confirm
    get 'orders/thanks' => 'orders#thanks', as: :orders_thanks
    resources :orders, only: [:index, :new, :create, :show]
    #顧客情報関連
    resource :customers, only: [:show, :edit, :update]
    get 'delete_account' => 'customers#delete_account', as: :delete_account
    patch 'delete_account' => 'customers#invalid', as: :invalid
    #顧客の配送先関連
    resources :destinations, except: [:new, :show]
  end

  namespace :admins do
    root 'homes#top'
    resources :products, only: [:index,:new,:create,:show,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders, only: [:index,:show,:update]
    resources :order_products, only: [:update]
  end
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
  registrations: 'customers/registrations'
  }

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  
  get 'search' => 'search#search', as: :search

end
