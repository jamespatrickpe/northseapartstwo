class Branch < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          NameValidations

  has_many :file_sets, as: :rel_file_set
  has_many :employee

  searchable do
    text :name
    text :remark
  end

end
