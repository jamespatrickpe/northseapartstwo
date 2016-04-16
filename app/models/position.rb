class Position < ActiveRecord::Base

  include BaseConcerns,
          NameValidations,
          RemarkValidations

  belongs_to :department, autosave: true
  validates_presence_of :department

end
