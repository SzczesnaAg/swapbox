class SwapsController < ApplicationController

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
        @swap.save!
        redirect_to my_dashboard_path, notice: "Your swap request has been successfully sent!"
      else
        redirect_to products_path, notice: "You have no available products to swap!"
      end
    else
      redirect_to new_user_session_url
    end
    authorize @swap
  end

  def mark_as_rejected
    @swap = Swap.find(params[:id])
    @product = @swap.product
    @product.status = "available"
    @product.save
    @swap.status = "rejected"
    @swap.save
    redirect_to my_dashboard_path, notice: "A swap offer rejected successfully!"
    authorize @swap
  end

  def choose_item
    @swap = Swap.find(params[:id])
    @products = @swap.user.products.available

    authorize @swap
  end

  def mark_as_accepted
    @swap = Swap.find(params[:id])
    @product = @swap.product
    @product.status = "taken"
    @product.save
    @swap.other_product = Product.find(params[:other_product_id])
    @swap.other_product.status = "taken"
    @swap.other_product.save
    @swap.status = "accepted"
    @swap.save
    redirect_to my_dashboard_path, notice: "Congrats! You made a swap."
    authorize @swap
  end

  private

  def swap_params
    params.require(:swap).permit(:status, :note, :product_id, :user_id)
  end
end
