class DutyStatus < ActiveRecord::Base

  include BaseConcerns
  include RemarkValidations

  belongs_to :employee

  validates_presence_of :datetime_of_implementation
  validates :active, inclusion: { in: [true, false] }

  # Implement Active/Inactive Duty Status

end