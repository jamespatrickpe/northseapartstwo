class InstitutionalAdjustmentSet < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee
  belongs_to :institution_employee
  belongs_to :institutional_adjustment

  validates_presence_of :institutional_ID
  validates_length_of :institutional_ID, maximum: 512

end
