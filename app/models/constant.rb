class Constant < ActiveRecord::Base

  include BaseConcerns
  include RemarkConcerns
  include NameConcerns
  include DateOfImplementationConcerns

  validates_presence_of :value
  validates_length_of :value, maximum: 128

  validates_presence_of :constant_type
  validates_length_of :constant_type, maximum: 128

  searchable do

    string :constant_type
    text :constant_type

  end

  def self.get_constant_in_period(date_time_of_implementation, constant_type)

    search  = Constant.search do
      with(:constant_type, constant_type)
      with(:date_of_implementation).less_than_or_equal_to(date_time_of_implementation)
    end
    results = search.results
    results.first

  end

end
