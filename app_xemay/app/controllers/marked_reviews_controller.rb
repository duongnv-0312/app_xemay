class MarkedReviewsController < ApplicationController
  load_and_authorize_resource :user, :review

  def create
    @review = Review.find params[:marked_review][:review_id]
    current_user.mark @review
    respond_to do |format|
      format.html {redirect_to @review}
      format.js
    end
  end

  def destroy
    @marked_review = MarkedReview.find(params[:id])
    @review = @marked_review.review
    current_user.unmark @review
    respond_to do |format|
      format.html {redirect_to @review}
      format.js
    end
  end
end
