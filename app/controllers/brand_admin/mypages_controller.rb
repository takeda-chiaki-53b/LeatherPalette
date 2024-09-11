class BrandAdmin::MypagesController < ApplicationController
  def show
    @user = current_user
    @posts = Post.includes(:user).where(user_id: current_user.id).order(created_at: :desc)
  end
end
