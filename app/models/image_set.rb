class ImageSet < ActiveRecord::Base


  belongs_to :rel_image_set, polymorphic: true

  mount_uploader :picture, RelatedImageUploader
  validates_length_of :remark , maximum: 256
  validates :picture,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }
end
