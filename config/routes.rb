Rails.application.routes.draw do
  root "tops#index"

  # 新規登録、ログイン、ログアウト
  resources :users, only: %i[new create]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  # Google 認証
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  # ブランドアカウントのルート
  namespace :brand_admin do
    resources :users, only: %i[new create]
    resource :mypage, only: %i[show]
    resources :products, only: %i[index new create show edit update destroy]
  end

  # 投稿機能関連
  resources :posts, only: %i[index new create show edit update destroy] do
    collection do
      get :favorites
    end
  end

  # お気に入り機能関連
  resources :favorites, only: %i[create destroy]

  # 検索機能関連
  resources :searches, only: %i[index] do
    collection do
      post :result  # collectionを使い、リソース全体に対してのアクションとして扱う
    end
  end

  # マイページ（一般ユーザー用）
  resource :mypage, only: %i[show]

  # プロフィール
  resource :profile, only: %i[show edit update]

  # パスワードリセット
  resources :password_resets, only: %i[new create edit update ]
end
