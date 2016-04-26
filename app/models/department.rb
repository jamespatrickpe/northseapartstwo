class Department < ActiveRecord::Base

  include BaseConcerns
  include NameConcerns

  has_many :positions

end
