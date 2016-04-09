class Store < ActiveRecord::Base
  belongs_to :review

  has_many :products

  validates :name, presence: true
end
