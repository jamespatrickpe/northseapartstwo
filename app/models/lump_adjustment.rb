class LumpAdjustment < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          AmountValidations

  belongs_to :employee

  validates_presence_of :datetime_of_implementation
end