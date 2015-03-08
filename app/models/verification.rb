class Verification < ActiveRecord::Base
  belongs_to :access

  validates_presence_of :temp_email
  validates_presence_of :access_id
  validates :hashlink, uniqueness: true
end
