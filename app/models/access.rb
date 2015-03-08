class Access < ActiveRecord::Base

  belongs_to :verification
  belongs_to :entity, autosave: true

  has_secure_password

  validates_presence_of :username
  validates :username, uniqueness: true
  validates_length_of :username, maximum: 64, message: "username must be less than 15 characters"
  validates_length_of :username, minimum: 3, message: "username must be more than 3 characters"

end
