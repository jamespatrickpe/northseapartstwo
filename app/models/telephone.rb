class Telephone < ActiveRecord::Base

  include BaseConcerns,
          Remark

  belongs_to :telephonable, polymorphic: true

  validates_length_of :digits , maximum: 32, message: "digits must be less than 32 characters"

end
