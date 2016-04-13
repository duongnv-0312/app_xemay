class ReviewsController < ApplicationController
  before_action :reviews
  before_action :find_review, only: [:show, :edit, :update]
  load_resource

  def index
  end

  def show
    @user = @review.user
    @comment = @review.comments.build
  end

  def new
    @review = Review.new
    @store = @review.build_store
    @store.images.build
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
    params.require(:review).permit :content, :average_rating, :total_rating, :user_id,
      store_attributes: [:id, :name, :address, :phone_number, :owner, :review_id,
        images_attributes: [:id, :image, :caption, :store_id],
        coordinate_attributes: [:id, :lat, :lng, :region_id]]
  end

  def reviews
    @reviews = Review.all
  end

  def find_review
    @review = Review.find params[:id]
  end
end
