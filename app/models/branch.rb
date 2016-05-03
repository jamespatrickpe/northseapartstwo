class Branch < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns,
          NameConcerns,
          ContactableConcerns

  has_many :file_sets, as: :rel_file_set
  has_many :employee

  has_many :file_sets, as: :filesetable
  has_many :image_sets, as: :imagesetable
  has_many :link_set, as: :linksetable

end
