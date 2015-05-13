class FileSet < ActiveRecord::Base

  belongs_to :rel_file_set, polymorphic: true

  mount_uploader :path, RelatedFileUploader
  validates_length_of :description , maximum: 256, message: "description must be less than 256 characters"
  validates :path,
            :presence => true,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }
end
