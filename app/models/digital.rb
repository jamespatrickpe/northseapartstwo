class Digital < ActiveRecord::Base

  belongs_to :rel_model, polymorphic: true
  # validates_presence_of :actor
  validates_length_of :url , maximum: 512
  validates_length_of :remark , maximum: 256
end
