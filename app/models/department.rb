class Department < ActiveRecord::Base

  include BaseConcerns
  include Name

  has_many :positions

end
