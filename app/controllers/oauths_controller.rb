class OauthsController < ApplicationController
  skip_before_action :require_login, only: %i[oauth callback]

  def oauth
    # 指定されたプロバイダの認証ページにユーザーをリダイレクトさせる
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    # 既存のユーザーをプロバイダ情報を元に検索し、存在すればログイン
    if (@user = login_from(auth_params[:provider]))
      redirect_to root_path, success: "Googleアカウントでログインしました"
    else
      begin
        # ユーザーが存在しない場合はプロバイダ情報を元に新規ユーザーを作成し、ログイン
        signup_and_login(provider)
        redirect_to root_path, success: "Googleアカウントでログインしました"
      rescue StandardError => e
        redirect_to root_path, danger: "Googleアカウントでログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :scope, :authuser, :prompt)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
