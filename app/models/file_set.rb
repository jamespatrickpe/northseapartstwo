class FileSet < ActiveRecord::Base
  
  include BaseConcerns,
          RemarkValidations

  belongs_to :rel_file_set, polymorphic: true

  mount_uploader :file, RelatedFileUploader

  validates :file,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }
end
