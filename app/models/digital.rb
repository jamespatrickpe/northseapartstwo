class Digital < ActiveRecord::Base

  include BaseConcerns
  include RemarkValidations

  belongs_to :rel_model, polymorphic: true

  validates_length_of :url , maximum: 512

end
