class Association < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns

  searchable do
    string :model_one_type
    string :model_two_type
    text :model_one_type
    text :model_two_type
  end

  validates :model_one_id, :model_one_type, :model_two_id, :model_two_type, :presence => true

end
