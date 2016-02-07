class Actor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  include UUIDHelper

  has_one :access, autosave: true
  has_one :employee, autosave: true
  has_many :file_sets, as: :rel_file_set
  has_many :image_sets, as: :rel_image_set
  has_many :link_set
  has_many :telephones
  has_many :addresses
  has_many :digitals

  # has_and_belongs_to_many :expenses

  mount_uploader :logo, AvatarUploader
  validates :name, uniqueness: true
  validates_presence_of :name
  validates_length_of :description, maximum: 256

  def actor_name
    actor.name
  end

  validates :logo,
            :file_size => {
                :maximum => 3.5.megabytes.to_i
            }

end

