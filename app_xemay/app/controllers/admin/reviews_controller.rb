class Admin::ReviewsController < ApplicationController
  before_action :reviews

  def index
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new review_params
    if @review.save
      redirect_to admin_reviews_path
    else
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit :content, :average_rating, :total_rating
  end

  def reviews
    @reviews = Review.all
  end
end
