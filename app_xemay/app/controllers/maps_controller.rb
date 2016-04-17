class MapsController < ApplicationController
  before_action :reviews

  def index
  end

  private
  def reviews
    @coordinates = Coordinate.all
    @stores = @coordinates.map &:store
    @reviews = @stores.map &:review
  end
end
