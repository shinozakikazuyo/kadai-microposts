Rails.application.routes.draw do
  
  #トップページ
  root to: 'toppages#index'
  
  #サインイン
  get 'signup', to: 'users#new'
  
  #ユーザ登録
  resources :users, only: [:index, :show, :new, :create]
  
  #ログイン
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
end
