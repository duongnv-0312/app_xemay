class Image < ActiveRecord::Base
  belongs_to :store
  mount_uploaders :images, ImageUploader
end
