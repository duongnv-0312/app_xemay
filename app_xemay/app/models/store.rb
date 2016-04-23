class Store < ActiveRecord::Base
  ratyrate_rateable "attitude", "price", "specialize"

  belongs_to :review

  has_one :coordinate, dependent: :destroy

  has_many :products
  has_many :images

  validates :name, presence: true

  accepts_nested_attributes_for :coordinate, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true

  delegate :lat, :lng, to: :coordinate, prefix: true, allow_nil: true
end
