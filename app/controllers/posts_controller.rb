class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_brand_admins, only: %i[new create edit update]
  before_action :set_products, only: %i[new create show edit update]

  def index
    @posts = Post.published.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.brand_admin_id = params[:post][:brand_admin_id].presence # nilまたは空文字の場合は自動的にnilになる

    # ステータスがdraftで、bodyが空の場合は「未登録」の文字を設定
    if @post.draft? && @post.body.blank?
      @post.body = "メッセージ未登録"
    end

    if @post.save
      if @post.draft?
        redirect_to mypage_path, success: "下書きに保存しました"
      elsif @post.unpublished?
        redirect_to mypage_path, success: "非公開の投稿に保存しました"
      else
        redirect_to posts_path, success: "投稿を公開しました"
      end
    else
      flash.now[:danger] = "投稿の作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    # 投稿のブランドidに一致するuserが見つかれば、その情報を取得、
    # 見つからなければnilを代入しエラーハンドリングを行う：brand_admin_id(アイテム情報のブランド)を未選択状態(nil)にする
    @brand_admin = User.find_by(id: @post.brand_admin_id) || begin
      @post.brand_admin_id = nil
    end

    # @productsからproduct_idに基づいて関連するproductを取得
    @product = @products.find { |product| product.id == @post.product_id }
    # 商品名と商品画像を取得
    @product_name = @product&.product_name
    @product_image = @product&.product_image

    # 自分の投稿ならそのまま表示し、他ユーザーの投稿であれば、公開ステータスだけを表示する
    if
      @post.user == current_user # 現在のユーザーがその投稿の作成者かどうかをチェック
    else
      @post = Post.published.find(params[:id]) # 自分以外の投稿なら、公開ステータスの投稿のみを表示
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    # ステータスがdraftで、bodyが空の場合は「未登録」の文字を設定
    if @post.draft? && post_params[:body].blank?
      @post.body = "メッセージ未登録"
    else
      # ステータスがdraftではない、または空でない場合、# 入力されている値を使う
      @post.body = post_params[:body]
    end

    # post_paramsにある他の情報に加えてbodyに現在の内容を追加する
    if @post.update(post_params.merge(body: @post.body))
      if @post.draft?
        redirect_to post_path(@post), success: "下書きに保存しました"
      elsif @post.unpublished?
        redirect_to post_path(@post), success: "非公開の投稿に保存しました"
      else
        redirect_to post_path(@post), success: "投稿を更新しました"
      end
    else
      flash.now[:danger] = "投稿の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, success: "投稿を削除しました", status: :see_other
  end

  def favorites
    @favorite_posts = current_user.favorite_posts.published.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def product_select
    @brand = User.find(params[:id])
    @products = @brand.products.order(product_name: :asc)

    respond_to do |format|
      format.json { render json: @products }
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :post_image, :post_image_cache, :used_year, :brand_admin_id, :product_id, :color, :care_item, :care_frequency, :care_howto, :status)
  end

  def set_brand_admins
    @brand_admins = User.brand_admins.order(name: :asc) # スコープでブランド管理者のユーザーを取得
  end

  def set_products
    @products = Product.includes(:user).order(product_name: :asc)
  end
end
