class RestDay < ActiveRecord::Base

  include BaseConcerns

  belongs_to :employee

  validates_length_of :day , maximum: 64
  validates_presence_of :datetime_of_implementation

end
