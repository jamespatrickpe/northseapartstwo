class Attendance < ActiveRecord::Base

  include BaseConcerns
  include Remark

  belongs_to :employee

end
