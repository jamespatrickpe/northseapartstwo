class Branch < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns,
          NameConcerns,
          ContactableConcerns,
          AssociatedFilesConcerns

  has_many :file_sets, as: :rel_file_set
  has_many :employee

end
