class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show; end

  def edit
    # Googleアカウントの場合にビューを出し分ける為
    @google_user = @user.email.include?("@gmail.com")
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: "ユーザー情報を更新しました"
    else
      flash.now[:danger] = "ユーザー情報の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :avatar_cache)
  end
end
