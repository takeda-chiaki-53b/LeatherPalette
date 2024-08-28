class BrandAdmin::UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = :brand_admin # :brand_adminを設定

    if @user.save
      redirect_to login_path, success: "ブランドアカウント登録が完了しました"
    else
      flash.now[:danger] = "ブランドアカウント登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
