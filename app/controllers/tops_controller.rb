class TopsController < ApplicationController
  skip_before_action :require_login, only: %i[index terms_of_use]

  def index
  end

  def terms_of_use; end
end
