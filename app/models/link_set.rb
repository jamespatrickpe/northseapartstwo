class LinkSet < ActiveRecord::Base

  belongs_to :rel_link_set, polymorphic: true
  validates_length_of :label , maximum: 128, message: "description must be less than 128 characters"
  validates_length_of :url , maximum: 512, message: "url must be less than 128 characters"

end
