class CommentsController < ApplicationController
  def create
    @review = Review.find params[:review_id]
    @comment = @review.comments.new comment_params
    @comment.user_id = current_user.id
    @comment.start_time = Time.now
    @comment.save
  end

  private
  def comment_params
    params.require(:comment).permit :content, :start_time,
      :rating_point, :user_id, :review_id
  end
end
