class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @user = User.find(params[:id])
    authorize @user
    @review = Review.new
    @reviews = Review.where(user: @user)
    @products = Product.where(user_id: @user.id, status: 0)
  end
end
