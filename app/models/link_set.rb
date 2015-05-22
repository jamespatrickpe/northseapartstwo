class LinkSet < ActiveRecord::Base

  include UUIDHelper

  belongs_to :rel_link_set, polymorphic: true
  validates_length_of :label , maximum: 128
  validates_length_of :url , maximum: 512

end
