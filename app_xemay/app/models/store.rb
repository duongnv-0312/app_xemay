class Store < ActiveRecord::Base
  belongs_to :review

  has_one :coordinate

  has_many :products
  has_many :images

  validates :name, presence: true
end
