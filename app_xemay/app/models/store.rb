class Store < ActiveRecord::Base
  belongs_to :reviews

  has_many :products
end
