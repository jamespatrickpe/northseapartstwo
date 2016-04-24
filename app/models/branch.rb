class Branch < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          NameValidations

  has_many :file_sets, as: :rel_file_set
  has_many :employee

  has_many :file_sets, as: :filesetable
  has_many :image_sets, as: :imagesetable
  has_many :link_set, as: :linksetable

  has_many :telephones, as: :telephonable
  has_many :addresses, as: :addressable
  has_many :digitals, as: :digitable

  searchable do
    text :name
    text :remark
  end

end
