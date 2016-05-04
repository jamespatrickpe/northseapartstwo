class Telephone < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns

  belongs_to :telephonable, polymorphic: true


  searchable do

    text :telephonable do
      polymorphic_searchable_representation(telephonable)
    end

    string :telephonable do
      polymorphic_searchable_representation(telephonable)
    end

  end

  validates_length_of :digits , maximum: 32, message: "digits must be less than 32 characters"

end
