class Review < ActiveRecord::Base
  has_many :reviews
  has_many :marks

  belongs_to :store
  belongs_to :user
end
