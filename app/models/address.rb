class Address < ActiveRecord::Base

  include BaseConcerns,
          Remark


  belongs_to :addressable, polymorphic: true

  searchable do
    string :longitude, :latitude, :remark
    text :longitude, :latitude, :remark
    text :addressable do
      addressable.try(:name)
    end
  end

  validates_numericality_of :longitude
  validates_numericality_of :latitude

end
