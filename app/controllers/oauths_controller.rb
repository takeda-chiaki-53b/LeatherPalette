class OauthsController < ApplicationController
  skip_before_action :require_login, only: %i[oauth callback]

  def oauth
    # Googleログインボタンが押されると、アプリからプロバイダー（ここではGoogle）へアクセストークンの要求を出す
    login_at(auth_params[:provider])

    # Googleの認可サーバーはユーザーを認証画面に移動させ連携の許可を待つ
    # ユーザーが許可を出すと、認可サーバーはアクセストークンを生成する
    # 生成したアクセストークンをアプリ側へ発行し、そのアクセストークンを手に入れた状態でユーザー情報取得の「認可」が完了する
    # 認可が下りれば callback の url にリダイレクトされる
  end

  def callback
    # どのサービス（プロバイダー）からログインしようとしているのか情報を取得する
    # oauthアクションで指定したプロバイダーの情報を使うため
    provider = auth_params[:provider]

    # プロバイダー情報を使ってログインを試みる(authenticationsテーブルを参照し、一致するユーザーを探す)
    # 情報取得にはoauthアクションで取得したアクセストークンをGoogleAPIへ渡す
    @user = login_form(pdovider)


    # authenticationsテーブルにプロバイダー情報と一致するユーザーが見つからなかった場合
    unless @user
      # プロバイダーからユーザーのハッシュを取得する
      sorcery_fetch_user_hash(provider)
      # 取得した情報からメールアドレスを使ってusersテーブルで既存のユーザーを探す
      @user = User.find_by(email: @user_hash[:user_info]["email"])

      # プロバイダーから取得したメールアドレスが、usersテーブルの既存ユーザー情報に存在する場合
      if @user
        # 既存のユーザーにプロバイダ情報を追加(authenticationsテーブルに)
        @user.add_provider_to_user(provider, @user_hash[:uid].to_s)
      else
        # usersテーブルにユーザーを新規作成、一緒にauthenticationsテーブルにプロバイダー情報も登録
        @user = create_from(provider)
      end

      reset_session
      auto_login(@user)
    end

    redirect_to posts_path, notice: "Googleアカウントでログインしました"
  rescue StandardError
    redirect_to login_path, alert: "Googleアカウントでログインに失敗しました"
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
