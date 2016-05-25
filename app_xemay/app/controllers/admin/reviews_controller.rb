class Admin::ReviewsController < ApplicationController
  before_action :reviews, :top_ten_rate, only: :index
  before_action :find_review, only: [:show, :edit, :update]
  load_and_authorize_resource :store, :coordinate, :product, except: [:index, :show]

  def search
    index
    render :index
  end

  def index
    @reviews = @q.result.eager_load(:store).to_a.uniq.reverse
    @stores = @reviews.map(&:store)
  end

  def show
    @user = @review.user
    @store = @review.store
    @products = @store.products
    @images = @store.images
    @comment = @review.comments.build
    @lat = @store.coordinate_lat
    @lng = @store.coordinate_lng

    @average_rating = @store.average("quality") ? @store.average("quality").avg : 0
    @total_rater = @store.rates("quality") ? @store.rates("quality").count : 0
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

  def edit
  end

  def update
    if @review.update review_params
      redirect_to @review
    else
      render :edit
    end
  end

  private
  def review_params
    params.require(:review).permit :content, :user_id,
      store_attributes: [:id, :name, :address, :phone_number, :owner, :review_id,
        images_attributes: [:id, :image, :store_id],
        coordinate_attributes: [:id, :lat, :lng, :store_id, :region_id],
        products_attributes: [:id, :name, :price, :store_id]]
  end

  def reviews
    @reviews = Review.all
  end

  def find_review
    @review = Review.find params[:id]
  end

  def top_ten_rate
    @top_ten_ratings = if Store.all.count > 10
      Store.all.order("avg_rating ASC").order("created_at DESC").first 10
    else
      Store.all
    end
  end
end
