class SystemActor < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns,
          NameConcerns,
          ContactableConcerns,
          AssociatedFilesConcerns

  has_one :access, autosave: true
  has_one :employee, autosave: true

  has_many :file_sets, as: :filesetable
  has_many :image_sets, as: :imagesetable
  has_many :link_set, as: :linksetable

  mount_uploader :logo, AvatarUploader, :on => :file_name
  validates :logo,
            :file_size => {
                :maximum => 3.5.megabytes.to_i
            }

end