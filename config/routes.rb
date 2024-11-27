Rails.application.routes.draw do
  root "tops#index"

  # 利用規約とプライバシーポリシー
  get "terms_of_use", to: "tops#terms_of_use"
  get "privacy_policy", to: "tops#privacy_policy"

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
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Railsアプリケーションの開発環境で、LetterOpenerWebのエンジンを指定したパス（ここでは"/letter_opener"）でマウントするという意味。
  # これによって、開発環境で/letter_openerにアクセスすると、送信されたメールを確認できるようになる
end
