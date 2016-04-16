class LumpAdjustment < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          AmountValidations

  belongs_to :employee

  validates_presence_of :date_of_implementation, maximum: 256

  validates :signed_type, inclusion: { in: [true, false] }

end
