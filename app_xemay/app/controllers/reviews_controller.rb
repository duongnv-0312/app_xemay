class ReviewsController < ApplicationController
  before_action :reviews
  before_action :find_review, only: [:show, :edit, :update]

  def index
  end

  def show
    @user = @review.user
    @comment = @review.comments.build
  end

  def new
    @review = Review.new
    @address = @review.build_store
  end

  def create
    @review = Review.new review_params
    if @review.save
      redirect_to reviews_path
    else
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit :content, :average_rating,
      :total_rating, :user_id
  end

  def reviews
    @reviews = Review.all
  end

  def find_review
    @review = Review.find params[:id]
  end
end
