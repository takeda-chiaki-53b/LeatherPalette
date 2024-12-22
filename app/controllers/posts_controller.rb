class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @posts = Post.published.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
    @brand_admins = User.brand_admins # スコープでブランド管理者のユーザーを取得
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.brand_admin_id = params[:post][:brand_admin_id].presence # nilまたは空文字の場合は自動的にnilになる

    # params[:draft]があれば下書き、params[:unpublished]があれば非公開、どちらもなければ公開投稿
    @post.status =
      if params[:draft].present?
        :draft
      elsif params[:unpublished].present?
        :unpublished
      else
        :published
      end

    if @post.save
      if @post.draft?
        redirect_to posts_path, success: "下書きに保存しました"
      elsif @post.unpublished?
        redirect_to posts_path, success: "非公開の投稿に保存しました"
      else
        redirect_to posts_path, success: "投稿を公開しました"
      end
    else
      @brand_admins = User.brand_admins # newビューを再表示する際に、スコープでブランド管理者のユーザーを再度取得
      flash.now[:danger] = "投稿メッセージを入力していないと投稿できません"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @brand_admin = User.find(@post.brand_admin_id) if @post.brand_admin_id.present? # 投稿にブランドが設定されている場合、その情報を取得
    @product_name = Product.find_by(id: @post.product_id)&.product_name # 商品名の取得

    # 自分の投稿ならそのまま表示し、他ユーザーの投稿であれば、公開ステータスだけを表示する
    if
      @post.user == current_user # 現在のユーザーがその投稿の作成者かどうかをチェック
    else
      @post = Post.published.find(params[:id]) # 自分以外の投稿なら、公開ステータスの投稿のみを表示
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
    @brand_admins = User.brand_admins # スコープ
  end

  def update
    @post = current_user.posts.find(params[:id])
    @brand_admins = User.brand_admins # スコープ

    # params[:published]があれば公開、params[:unpublished]があれば非公開、どちらもなければ下書き
    @post.status =
      if params[:published].present?
        :published
      elsif params[:unpublished].present?
        :unpublished
      else
        :draft
      end

    if @post.update(post_params)
      if @post.draft?
        redirect_to post_path(@post), success: "下書きに保存しました"
      elsif @post.unpublished?
        redirect_to post_path(@post), success: "非公開の投稿に保存しました"
      else
        redirect_to post_path(@post), success: "投稿を更新しました"
      end
    else
      flash.now[:danger] = "投稿メッセージを入力していないと投稿できません"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, success: "投稿を削除しました", status: :see_other
  end

  def favorites
    @favorite_posts = current_user.favorite_posts.published.includes(:user).order(created_at: :desc)
  end

  def product_select
    @brand = User.find(params[:id])
    @products = @brand.products

    respond_to do |format|
      format.json { render json: @products }
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :used_year, :brand_admin_id, :product_id, :color, :care_item, :care_frequency, :care_howto, :status, post_image: [], post_image_cache: [])
  end
end
