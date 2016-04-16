class Branch < ActiveRecord::Base

  include BaseConcerns

  has_many :employee

end
