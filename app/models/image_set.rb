class ImageSet < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns,
          AssociatedFilesConcerns

  belongs_to :imagesetable, polymorphic: true

  searchable do
    string :picture
    text :imagesetable do
      polymorphic_searchable_representation(imagesetable)
    end
  end

  mount_uploader :picture, RelatedImageUploader, :on => :file_name
  validates :picture,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }

  validates :picture, :presence => true
  validates_integrity_of :picture
  validates_processing_of :picture

  validates_numericality_of :priority

end
