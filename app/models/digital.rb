class Digital < ActiveRecord::Base
  include UUIDHelper

  belongs_to :contact_detail, autosave: true
  validates_presence_of :contact_detail
  validates_length_of :url , maximum: 512
  validates_length_of :description , maximum: 256
end
