class Entity < ActiveRecord::Base

  has_one :access, autosave: true
  has_many :contact_detail, autosave: true

  mount_uploader :logo, AvatarUploader
  validates_presence_of :name
  validates :name, uniqueness: true
  validates_length_of :description, maximum: 256, message: "description must be less than 256 characters"

end
   