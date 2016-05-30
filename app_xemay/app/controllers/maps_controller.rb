class MapsController < ApplicationController
  before_action :reviews

  def index
    @stores = if params[:store].present?
      @stores.select{|store| store.store_type == params[:store].values.first}
    else
      @stores
    end
  end

  private
  def reviews
    @coordinates = Coordinate.all
    @stores = @coordinates.map &:store
    @reviews = @stores.compact.map &:review
  end
end
