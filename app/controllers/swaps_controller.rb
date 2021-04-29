class SwapsController < ApplicationController
  before_action :set_swap, only: [:show, :mark_as_rejected]

  def create
    @product = Product.find(params[:product_id])
    @swap = Swap.new
    @swap.product = @product
    @swap.user = current_user
    if user_signed_in?
      if current_user.id == @product.user_id
        redirect_to products_path, notice: "It's your product, swap unavailable!"
      elsif current_user.products.where(status: 0).count.positive?
        @product.status = "onhold"
        @product.save
        @swap.save
        redirect_to products_path, notice: "Your swap request has been successfully sent!"
      else
        redirect_to products_path, notice: "You have no available products to swap!"
      end
    else
      redirect_to new_user_session_url
    end
    authorize @swap
  end

  def show
  end

  def sent_requests
    @swaps = Swap.where(user_id: current_user.id)
  end

  def requests_for_owner
    @swaps = Swap.products.where(user_id: current_user.id)
  end

  def mark_as_rejected
    @swap.product = @product
    @product.status = "available"
    @product.save
    @swap.status = "rejected"
    @swap.save
    redirect_to products_path, notice: "Swap request has been rejected!"
  end

  private

  def swap_params
    params.require(:swap).permit(:status, :note, :product_id, :user_id)
  end

  def set_swap
    @swap = Swap.find(params[:id])
    authorize @swap
  end
end
