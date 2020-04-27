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
    end
    #ユーザの検索結果を表示
    collection do
      get :search
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
  
end
