class Permission < ActiveRecord::Base
  include UUIDHelper
  belongs_to :access
  validates_length_of :remark , maximum: 256, message: "remark must be less than 256 characters"
  validates_length_of :can , maximum: 256, message: "can must be less than 256 characters"
  validates_presence_of :access_id
  validates_presence_of :can
end
