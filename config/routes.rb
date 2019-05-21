Rails.application.routes.draw do
  devise_for :users #device機能

  root 'top#index' #top page

  get '/home/about' => 'top#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only:[:show, :index, :edit, :update]
  resources :books
end
