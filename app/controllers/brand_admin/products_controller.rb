class BrandAdmin::ProductsController < ApplicationController
  def index
    @products = current_user.products.includes(:user).order(created_at: :desc)
  end
end
