class SearchesController < ApplicationController
  skip_before_action :require_login, only: %i[index result product_select]
  before_action :set_brand_admins, only: %i[index result]

  def index
  end

  def result
    brand_admin_id = search_params[:brand_admin_id]
    product_id = search_params[:product_id]
    used_year = search_params[:used_year]
    color = search_params[:color]

    # @brand_adminsから選択されたIDに一致するユーザーを探す
    selected_brand = @brand_admins.find { |brand| brand.id == brand_admin_id.to_i }

    # 選択されたパラメータをインスタンス変数にセット(検索結果に条件を表示させるため)
    @selected_brand_name = selected_brand ? selected_brand.name : nil # 見つかったブランドの名前をセットし、見つからない場合にはnilをセット
    @selected_product_name = Product.find_by(id: product_id)&.product_name
    @selected_used_year = used_year
    @selected_color = color

    # 投稿の初期値を全て取得
    @posts = Post.includes(:user).order(created_at: :desc)

    # 条件に基づいて絞り込みを行う
    @posts = @posts.brand_post_search(brand_admin_id) if brand_admin_id.present?
    @posts = @posts.product_post_search(product_id) if product_id.present?
    @posts = @posts.used_year_post_search(used_year) if used_year.present?
    @posts = @posts.color_post_search(color) if color.present?
  end

  def product_select
    @brand = User.find(params[:id])
    @products = @brand.products

    respond_to do |format|
      format.json { render json: @products }
    end
  end

  private

  def search_params
    params.permit(:brand_admin_id, :product_id, :used_year, :color)
  end

  def set_brand_admins
    @brand_admins = User.brand_admins.order(name: :asc) # スコープでブランド管理者のユーザーを取得
  end
end
