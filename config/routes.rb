Rails.application.routes.draw do
  resources :items do 
    collection do 
      put :generate
    end
  end
  resources :transfers
  resources :budgets
  resources :categories
  resources :accounts
  devise_for :users

  get 'administrators', to: 'administrators#index'
  get 'toggle_admin', to: 'administrators#toggle_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

 root to: 'accounts#index'
end
