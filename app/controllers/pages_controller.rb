class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:home, :index, :show, :faq]

  def home
  end

  def index
  end

  def show
  end

  def my_dashboard
    @user = current_user
    @products = Product.where(user_id: current_user.id)
    @swaps_requests = Swap.where(user_id: current_user.id, status: 0) # requested
    @swaps_requests_accepted = Swap.where(user_id: current_user.id, status: 1)
    @swaps_accepted = Swap.joins(:product).where("products.user_id = ?", current_user.id) & Swap.where(status: 1) # accepted
    @swaps_rejected = Swap.where(user_id: current_user.id, status: 2) # rejected

    @swaps = Swap.joins(:product).where("products.user_id = ?", current_user.id) & Swap.where(status: 0)
  end

  def faq
  end
end
