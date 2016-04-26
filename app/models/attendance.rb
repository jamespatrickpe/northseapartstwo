class Attendance < ActiveRecord::Base

  include BaseConcerns
  include RemarkConcerns

  belongs_to :employee

end
