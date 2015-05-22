require 'file_size_validator'
class Entity < ActiveRecord::Base

  include UUIDHelper

  has_one :access, autosave: true
  has_one :employee, autosave: true
  has_many :contact_detail, autosave: true
  has_many :file_set
  has_many :link_set

  mount_uploader :logo, AvatarUploader
  validates_presence_of :name
  validates :name, uniqueness: true
  validates_length_of :description, maximum: 256

  def entity_name
    entity.name
  end

  validates :logo,
            :file_size => {
                :maximum => 25.megabytes.to_i
            }
end
   