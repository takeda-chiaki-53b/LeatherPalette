class BrandAdmin::MypagesController < ApplicationController
  def show
    @user = current_user
    @posts_published = @user.posts.published.order(created_at: :desc)
    @posts_unpublished = @user.posts.unpublished.order(created_at: :desc)
    @posts_draft = @user.posts.draft.order(created_at: :desc)
  end
end
