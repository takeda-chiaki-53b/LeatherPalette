class SearchesController < ApplicationController
  skip_before_action :require_login, only: %i[index result]

  def index
    @brand_admins = User.brand_admins # スコープでブランド管理者のユーザーを取得
  end

  def result
    search_brand_id = brand_search_params[:user_id]  # ストロングパラメーターを使用
    @posts = Post.published.brand_post_search(saerch_brand_id).includes(:user).order(created_at: :desc)
    #
  end

  private

  def brand_search_params
    params.require(:post).permit(:user_id)
  end
end
