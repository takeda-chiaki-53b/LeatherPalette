class BrandAdmin::MypagesController < ApplicationController
  def show
    @user = current_user
    @posts = current_user.posts.includes(:user).order(created_at: :desc)
  end
end
