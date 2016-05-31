class MapsController < ApplicationController
  before_action :reviews

  def index
    if params[:store].present?
      @stores = @stores.select{|store| store.store_type == params[:store].values.first}
      @coordinates = @stores.map &:coordinate
      @reviews = @stores.compact.map &:review
    end
  end

  private
  def reviews
    @coordinates = Coordinate.all
    @stores = @coordinates.map &:store
    @reviews = @stores.compact.map &:review
  end
end
