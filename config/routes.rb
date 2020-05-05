Rails.application.routes.draw do
  
  #トップページ
  root to: 'toppages#index'
  
  #サインイン
  get 'signup', to: 'users#new'
  #ユーザ登録
  resources :users, only: [:index, :show, :new, :create] do
    
    member do
      get :followings
      get :followers
      get :likes
    end

  end
  
  #ログイン
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #新規投稿
  resources :microposts, only: [:create, :destroy] 
  
  #フォロー
  resources :relationships, only: [:create, :destroy]
  
  #お気に入り
  resources :favorites, only: [:create, :destroy]
  
end
