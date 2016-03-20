class Store < ActiveRecord::Base
  has_many :reviews
  has_many :products
end
