class ReviewsController < ApplicationController
  before_action :reviews, only: :index
  before_action :find_review, only: [:show, :edit, :update]
  load_and_authorize_resource :store, :coordinate, :product, only: [:new, :create]

  def index
  end

  def show
    @user = @review.user
    @store = @review.store
    @products = @store.products
    @images = @store.images
    @comment = @review.comments.build
    @lat = @store.coordinate_lat
    @lng = @store.coordinate_lng

    if @store.average("quality")
      @average_rating = @store.average("quality").avg
      @total_rater = @store.rates("quality").count
    end
  end

  def new
    @review = Review.new
    @store = @review.build_store
    @store.images.build
    @store.build_coordinate
    @store.products.build
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
    params.require(:review).permit :content, :user_id,
      store_attributes: [:id, :name, :address, :phone_number, :owner, :review_id,
        images_attributes: [:id, :image, :caption, :store_id],
        coordinate_attributes: [:id, :lat, :lng, :store_id, :region_id],
        products_attributes: [:id, :name, :price, :store_id]]
  end

  def reviews
    @reviews = Review.all
  end

  def find_review
    @review = Review.find params[:id]
  end
end
