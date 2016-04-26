class Position < ActiveRecord::Base

  include BaseConcerns,
          NameConcerns,
          RemarkConcerns

  belongs_to :department, autosave: true
  validates_presence_of :department

end
