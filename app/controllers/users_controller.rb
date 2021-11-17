class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @user = User.find(params[:id])
    authorize @user
    @review = Review.new
    @reviews = Review.where(user: @user, state: "approved")
    @products = Product.where(user_id: @user.id, status: 0)

    @ratings = @reviews.map do |i|
      i.rating
    end
    if @ratings.sum > 0
      @avg_rating = (@ratings.sum / @reviews.count)
    else
      @avg_rating = 0
    end
  end
end
