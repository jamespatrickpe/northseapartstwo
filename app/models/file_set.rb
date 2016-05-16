class FileSet < ActiveRecord::Base
  
  include BaseConcerns,
          RemarkConcerns,
          AssociatedFilesConcerns

  belongs_to :filesetable, polymorphic: true

  searchable do
    string :file
    text :filesetable do
      polymorphic_searchable_representation(filesetable)
    end
    string :physical_storage
    text :physical_storage
  end

  mount_uploader :file, RelatedFileUploader
  validates :file,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }


end
