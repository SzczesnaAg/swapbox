class ReviewsController < ApplicationController
  before_action :find_user, only: [:new, :create]

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    authorize @review
    @review.user = @user
    if @review.save && @review.rating == 5
      @review.approve
      redirect_to @user, notice: "Review was successfully created!"
    elsif @review.save
      redirect_to @user, notice: "Review was sent for approval!"
    else
      redirect_to @user, notice: "Review not created. Please fill out both fields!"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
