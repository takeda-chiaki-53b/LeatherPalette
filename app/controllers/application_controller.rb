class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login
  before_action :check_brand_admin, if: :brand_admin_controller?
  add_flash_types :success, :danger

  private

  def not_authenticated
    redirect_to login_path
  end

  def check_brand_admin
    redirect_to root_path, danger: "権限がありません" unless current_user&.brand_admin?
  end

  def brand_admin_controller?
    controller_path.start_with?("brand_admin/")
  end
end
