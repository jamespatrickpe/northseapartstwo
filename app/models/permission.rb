class Permission < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns

  belongs_to :access

  validates_presence_of :access_id
  validates_presence_of :can
  validates_length_of :can , maximum: 256, message: "can must be less than 256 characters"

end