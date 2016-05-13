class RaterController < ApplicationController

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]

      render json: {
        average_rating: obj.average("quality").avg,
        total_rater: obj.rates("quality").count
        }, status: :ok
    else
      render json: {}, status: :ok
    end
  end
end
