class ContactDetail < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns

  belongs_to :contactable, polymorphic: true
  has_many :telephones
  has_many :digitals
  has_many :addresses

  searchable do

    string :contactable do
      polymorphic_searchable_representation(contactable)
    end

    text :contactable do
      polymorphic_searchable_representation(contactable)
    end

  end

end