class Coordinate < ActiveRecord::Base
  belongs_to :region
  belongs_to :store
end
