class SearchesController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @brand_admins = User.brand_admins # スコープでブランド管理者のユーザーを取得
  end
end
