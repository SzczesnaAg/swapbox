class SwapsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @swap = Swap.new
    @swap.product = @product
    @swap.user = current_user
    if user_signed_in?
      @product.status = "onhold"
      @product.save
      @swap.save

      redirect_to products_path, notice: "Your swap request has been successfully sent!"
    else
      redirect_to new_user_session_url
    end
    authorize @swap
  end

  private

  def swap_params
    params.require(:swap).permit(:status, :note, :product_id, :user_id)
  end
end
