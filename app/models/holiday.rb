class Holiday < ActiveRecord::Base

  include BaseConcerns
  include RemarkConcerns
  include NameConcerns
  include DateOfImplementationConcerns

  belongs_to :holiday_type

  validates_uniqueness_of :date_of_implementation
  validates_presence_of :holiday_type

  searchable do
    string :holiday_type
    text :holiday_type
  end

end
