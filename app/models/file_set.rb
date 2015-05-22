class FileSet < ActiveRecord::Base

  include UUIDHelper

  belongs_to :rel_file_set, polymorphic: true

  mount_uploader :path, RelatedFileUploader
  validates_length_of :description , maximum: 256
  validates :path,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }
end
