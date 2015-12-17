class ImageSet < ActiveRecord::Base

  include UUIDHelper
  belongs_to :rel_image_set, polymorphic: true

  mount_uploader :picture, RelatedImageUploader
  validates_length_of :description , maximum: 256
  validates :picture,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }
end
