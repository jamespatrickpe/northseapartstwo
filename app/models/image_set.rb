class ImageSet < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations

  belongs_to :rel_image_set, polymorphic: true

  mount_uploader :picture, RelatedImageUploader
  validates :picture,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }
end
