class HomeController < ApplicationController
  def index
    @user = get_active_user()
  end
end
