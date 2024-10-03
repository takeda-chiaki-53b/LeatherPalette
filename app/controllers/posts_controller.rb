class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
    @brand_admins = User.where(role: "brand_admin") # ブランド管理者のユーザーを取得
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.brand_admin_id = params[:post][:brand_admin_id].presence # nilまたは空文字の場合は自動的にnilになる
    if @post.save
      redirect_to posts_path, success: "投稿が完了しました"
    else
      @brand_admins = User.where(role: "brand_admin") # newビューを再表示する際に、@brand_adminsを再度取得
      flash.now[:danger] = "投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @brand_admin = User.find(@post.brand_admin_id) if @post.brand_admin_id.present? # 投稿にブランドが設定されている場合、その情報を取得
  end

  def edit
    @post = current_user.posts.find(params[:id])
    @brand_admins = User.where(role: "brand_admin") # ブランド管理者のユーザーを取得
  end

  def update
    @post = current_user.posts.find(params[:id])
    @brand_admins = User.where(role: "brand_admin") # ブランド管理者のユーザーを取得
    if @post.update(post_params)
      redirect_to post_path(@post), success: "投稿を更新しました"
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

  private

  def post_params
    params.require(:post).permit(:body, :used_year, :care_item, :care_frequency, :care_howto, :brand_admin_id, post_image: [], post_image_cache: [])
  end
end
