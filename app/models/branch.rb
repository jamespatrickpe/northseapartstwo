class Branch < ActiveRecord::Base

  include BaseConcerns

  has_many :file_sets, as: :rel_file_set
  has_many :employee

end
