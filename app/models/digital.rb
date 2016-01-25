class Digital < ActiveRecord::Base
  include UUIDHelper
  belongs_to :rel_model, polymorphic: true
  # validates_presence_of :actor
  validates_length_of :url , maximum: 512
  validates_length_of :description , maximum: 256
end
