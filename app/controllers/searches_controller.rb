class SearchesController < ApplicationController
  skip_before_action :require_login, only: %i[index result]

  def index
    @brand_admins = User.brand_admins # スコープでブランド管理者のユーザーを取得
  end

  def result
    search_brand_id = search_params[:user_id]
    used_year = search_params[:used_year]

    # ブランド検索
    @posts = Post.published.brand_post_search(search_brand_id).includes(:user).order(created_at: :desc)

    # 使用年数検索
    if used_year.present?
      @posts = Post.used_year_post_search(used_year) # スコープを使って絞り込み
    end
  end

  private

  def search_params
    params.require(:post).permit(:user_id, :used_year)
  end
end
