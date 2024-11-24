class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  # 環境変数GMAIL_USERNAMEから値を取得し、存在しない場合はnilを返す
  default from: ENV.fetch("GMAIL_USERNAME", nil)

  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(
      to: user.email,
      subject: t("password_reset_mail.subject")
    ) do |format|
      format.text { render "user_mailer/reset_password_email" }  # .text.erb を使用
      format.html { render "user_mailer/reset_password_email" }  # .html.erb を使用
      # メールを受け取るクライアント（メールソフトやアプリ）は、受信者の設定や環境に基づいて、自動で適切なフォーマット（テキストかHTML）を選んで表示する
    end
  end
end
