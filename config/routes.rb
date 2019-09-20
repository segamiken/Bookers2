Rails.application.routes.draw do
  devise_for :users #device機能

  root 'top#index' #top page
  get '/home/about' => 'top#about'
  get '/users/history' => 'users#history'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only:[:show, :index, :edit, :update] do
  	resource :relationships, only: [:create, :destroy]
  	get :follows, on: :member
  	get :followers, on: :member
  end

  resources :books do
  	resources :post_comments, only: [:create, :destroy, :edit, :update]
  	resource :favorites, only: [:create, :destroy]
  end
end
