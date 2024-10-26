class SearchesController < ApplicationController
  skip_before_action :require_login, only: %i[index result]

  def index
    @brand_admins = User.brand_admins # スコープでブランド管理者のユーザーを取得
  end

  def result
    brand_name = search_params[:brand_name]
    used_year = search_params[:used_year]

    # ブランド検索
    # パラメーターで受け取ったブランド名と一致する、brand_admin権限を持つユーザーを探す。
    brand_admin = User.brand_admins.find_by(name: brand_name)
    # 上記で一致するユーザーが存在した場合、投稿の検索
    if brand_admin.present?
      @posts = Post.brand_post_search(brand_admin.id).includes(:user).order(created_at: :desc)
    end

    # 使用年数検索
    if used_year.present?
      @posts = Post.used_year_post_search(used_year).order(created_at: :desc) # スコープを使って絞り込み
    end
  end

  private

  def search_params
    params.require(:post).permit(:brand_name, :used_year)
  end
end
