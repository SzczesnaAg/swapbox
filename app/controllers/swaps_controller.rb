class SwapsController < ApplicationController
  before_action :set_swap, only: [:show, :choose_item, :mark_as_rejected, :mark_as_accepted, :mark_as_exchanged, :mark_as_canceled, :mark_as_read]

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
        @swap.notify_owner = true
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

  def show
    @message = Message.new
    @user = @swap.user
    @other_user = @swap.product.user
    if current_user == @user
      @chat_user = @other_user
    elsif current_user == @other_user
      @chat_user = @user
    end

    mark_as_read
  end

  def mark_as_read
    if @swap.user_id == current_user.id
      @swap.notify_requester = false
    else
      @swap.notify_owner = false
    end
    @swap.save
  end

  def mark_as_rejected
    @product = @swap.product
    @product.status = "available"
    @product.save
    @swap.status = "rejected"
    @swap.save
    redirect_to my_dashboard_path, notice: "A swap offer rejected successfully!"
    authorize @swap
  end

  def choose_item
    mark_as_read
    @swaps = Swap.where(user_id: current_user.id, status: 0)
    @products = @swap.user.products.available
    @my_products = Product.where(user_id: current_user.id, status: 0)
    @user = @swap.user.first_name
    @swap_product = @swap.product.title
    if @my_products.count >= @swaps.count
      @swap_possible = true
    else
      @swap_possible = false
    end
  end

  def mark_as_accepted
    @product = @swap.product
    @product.status = "taken"
    @product.save
    @swap.other_product = Product.find(params[:other_product_id])
    @swap.other_product.status = "taken"
    @swap.other_product.save
    @swap.status = "accepted"
    @swap.notify_requester = true
    @swap.save
    redirect_to my_dashboard_path, notice: "Congrats! You made a swap."
  end

  def mark_as_exchanged
    @product = @swap.product
    @other_product = @swap.other_product
    if current_user.id == @product.user_id
      @product.status = "exchanged"
      @product.save
    else
      @other_product.status = "exchanged"
      @other_product.save
    end
    if @product.status == @other_product.status
      @swap.status = "exchanged"
      @swap.save
    end
    redirect_to my_dashboard_path, notice: "You confirmed receival of the product."
  end

  def mark_as_canceled
    @product = @swap.product
    @product.status = "available"
    @product.save
    @swap.status = "canceled"
    @swap.save
    redirect_to my_dashboard_path, notice: "Your swap request has been canceled."
  end

  private

  def set_swap
    @swap = Swap.find(params[:id])
    authorize @swap
  end
end
