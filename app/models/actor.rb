class Actor < ActiveRecord::Base

  include BaseConcerns
  include RemarkValidations
  include NameValidations

  has_one :access, autosave: true
  has_one :employee, autosave: true
  has_many :file_sets, as: :rel_file_set
  has_many :image_sets, as: :rel_image_set
  has_many :link_set
  has_many :telephones
  has_many :addresses
  has_many :digitals

  mount_uploader :logo, AvatarUploader
  validates :logo,
            :file_size => {
                :maximum => 3.5.megabytes.to_i
            }

end