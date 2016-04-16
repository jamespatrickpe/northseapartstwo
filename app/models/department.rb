class Department < ActiveRecord::Base

  include BaseConcerns
  include NameValidations

  has_many :positions

end
