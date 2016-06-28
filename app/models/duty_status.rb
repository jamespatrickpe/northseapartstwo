class DutyStatus < ActiveRecord::Base

  include BaseConcerns
  include RemarkConcerns

  belongs_to :employee
  belongs_to :branch

  validates_presence_of :datetime_of_implementation
  validates :active, inclusion: { in: [true, false] }

  # Implement Active/Inactive Duty Status

end