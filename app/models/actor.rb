class Actor < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          NameValidations

  has_one :access, autosave: true
  has_one :employee, autosave: true
  has_many :file_sets, as: :filesetable
  has_many :image_sets, as: :imagesetable
  has_many :link_set, as: :linksetable
  has_many :telephones, as: :telephonable
  has_many :addresses, as: :addressable
  has_many :digitals, as: :digitable

  mount_uploader :logo, AvatarUploader
  validates :logo,
            :file_size => {
                :maximum => 3.5.megabytes.to_i
            }

  searchable do
    text :name
    text :remark
  end

end