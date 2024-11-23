class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by_email(params[:email])
    @user&.deliver_reset_password_instructions!
    # 「存在しないメールアドレスです」という旨の文言を表示すると、逆に存在するメールアドレスを特定されてしまうため、
    # あえて成功時のメッセージを送信させている
    redirect_to login_path, success: "パスワード再設定のご案内メールを送信しました"
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    # @user が存在しない場合に not_authenticated メソッドを呼び出して認証されていないとみなし、処理を終了
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    # フォームから送られてきたパスワード確認用の値を@userのpassword_confirmation属性にセット
    # @user.password_confirmation～はパスワードとパスワード確認の値が一致するかどうかを検証するために必要なステップ
    # change_passwordメソッド(パスワード変更)が成功/失敗に応じてページ遷移を設定
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: "パスワードの再設定が完了しました"
    else
      flash.now[:danger] = "パスワードの再設定に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end
end
