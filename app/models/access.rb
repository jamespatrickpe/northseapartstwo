class Access < ActiveRecord::Base

  include UUIDHelper

  belongs_to :verification
  belongs_to :entity, autosave: true

  has_secure_password

  validates_presence_of :username
  validates :username, uniqueness: true
  validates_length_of :username, maximum: 64
  validates_length_of :username, minimum: 3

end
