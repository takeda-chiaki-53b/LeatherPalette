class SearchesController < ApplicationController
  skip_before_action :require_login, only: %i[index result]

  def index
    @brand_admins = User.brand_admins.order(name: :asc) # スコープでブランド管理者のユーザーを取得
  end

  def result
    brand_name = search_params[:brand_name]
    used_year = search_params[:used_year]

    # 選択されたパラメータをインスタンス変数にセット(検索結果に条件を表示させるため)
    @selected_brand_name = brand_name
    @selected_used_year = used_year

    # パラメーターで受け取ったブランド名と一致する、brand_admin権限を持つユーザーを探す。
    brand_admin = User.brand_admins.find_by(name: brand_name)

    # 投稿の初期値を全て取得
    @posts = Post.includes(:user).order(created_at: :desc)

    # 複数の条件がある場合の絞り込み
    if brand_admin.present? && used_year.present?
      @posts = @posts.brand_post_search(brand_admin.id).used_year_post_search(used_year) # スコープを活用

    # ブランド名のみパラメーターが存在した場合
    elsif brand_admin.present?
      @posts = @posts.brand_post_search(brand_admin.id)

    # 使用年数のみパラメーターが存在した場合
    elsif used_year.present?
      @posts = @posts.used_year_post_search(used_year)
    end
  end

  private

  def search_params
    params.permit(:brand_name, :used_year)
  end
end
