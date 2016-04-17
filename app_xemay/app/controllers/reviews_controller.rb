class ReviewsController < ApplicationController
  before_action :reviews, only: :index
  before_action :find_review, only: [:show, :edit, :update]
  load_resource

  def index
  end

  def show
    @user = @review.user
    @store = @review.store
    @comment = @review.comments.build
    @lat = @review.store.coordinate_lat
    @lng = @review.store.coordinate_lng
  end

  def new
    @review = Review.new
    @store = @review.build_store
    @store.images.build
    @store.build_coordinate
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
        coordinate_attributes: [:id, :lat, :lng, :store_id, :region_id]]
  end

  def reviews
    @reviews = Review.all
  end

  def find_review
    @review = Review.find params[:id]
  end
end
