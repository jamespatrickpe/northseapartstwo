class Digital < ActiveRecord::Base
  include UUIDHelper

  belongs_to :actor
  # validates_presence_of :actor
  validates_length_of :url , maximum: 512
  validates_length_of :description , maximum: 256
end
