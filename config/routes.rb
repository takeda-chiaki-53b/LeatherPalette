Rails.application.routes.draw do
  root "tops#index"

  # 新規登録、ログイン、ログアウト
  resources :users, only: %i[new create]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  # ブランドアカウントのルート
  namespace :brand_admin do
    resources :users, only: %i[new create]
    resource :mypage, only: %i[show]
  end

  # 投稿機能関連
  resources :posts, only: %i[index new create show edit update destroy]
end
