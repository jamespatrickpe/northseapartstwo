class FileSet < ActiveRecord::Base
  
  include BaseConcerns,
          RemarkConcerns

  belongs_to :filesetable, polymorphic: true

  searchable do
    string :file
    string :filesetable do
      polymorphic_searchable_representation(filesetable)
    end
  end

  searchable do
    string :file
  end

  mount_uploader :file, RelatedFileUploader
  validates :file,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }


end
