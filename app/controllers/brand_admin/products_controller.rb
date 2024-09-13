class BrandAdmin::ProductsController < ApplicationController
  skip_before_action :check_brand_admin, only: %i[show]

  def index
    @products = current_user.products.includes(:user).order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to brand_admin_products_path, success: "商品登録が完了しました"
    else
      flash.now[:danger] = "商品登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])
    if @product.update(product_params)
      redirect_to brand_admin_product_path(@product), success: "商品の編集が完了しました"
    else
      flash.now[:danger] = "商品の編集に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_image, :product_name)
  end
end
