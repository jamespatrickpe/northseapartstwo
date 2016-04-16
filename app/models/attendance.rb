class Attendance < ActiveRecord::Base

  include BaseConcerns
  include RemarkValidations

  belongs_to :employee

end
