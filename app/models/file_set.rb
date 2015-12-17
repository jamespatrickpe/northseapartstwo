class FileSet < ActiveRecord::Base

  include UUIDHelper
  belongs_to :rel_file_set, polymorphic: true

  mount_uploader :file, RelatedFileUploader
  validates_length_of :label , maximum: 256
  validates :file,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }
end
