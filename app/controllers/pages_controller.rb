class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  def home
  end

  def index
  end

  def show
  end

  def my_dashboard
    @user = current_user
    @products = Product.where(user_id: current_user.id)
  end
end
