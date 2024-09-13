class BrandAdmin::ProductsController < ApplicationController
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

  private

  def product_params
    params.require(:product).permit(:product_image, :product_name)
  end
end
