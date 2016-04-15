class Actor < ActiveRecord::Base

  include UUIDHelper

  has_one :access, autosave: true
  has_one :employee, autosave: true
  has_many :file_sets, as: :rel_file_set
  has_many :image_sets, as: :rel_image_set
  has_many :link_set
  has_many :telephones
  has_many :addresses
  has_many :digitals

  mount_uploader :logo, AvatarUploader
  validates :name, uniqueness: true
  validates_presence_of :name
  validates_length_of :remark, maximum: 256

end