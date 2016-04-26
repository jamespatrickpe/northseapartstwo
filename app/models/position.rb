class Position < ActiveRecord::Base

  include BaseConcerns,
          Name,
          Remark

  belongs_to :department, autosave: true
  validates_presence_of :department

end
