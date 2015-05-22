class Verification < ActiveRecord::Base

  include UUIDHelper
  belongs_to :access

  validates_presence_of :temp_email
  validates_presence_of :access_id
  validates :hashlink, uniqueness: true
end
