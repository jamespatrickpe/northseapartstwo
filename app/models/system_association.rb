class SystemAssociation < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns

  belongs_to :model_one, polymorphic: true
  belongs_to :model_two, polymorphic: true

  validates :model_one_id, :model_one_type, :model_two_id, :model_two_type, :presence => true

  searchable do

    text :model_one do
      polymorphic_searchable_representation(model_one)
    end

    text :model_two do
      polymorphic_searchable_representation(model_two)
    end

  end

  def self.allowed_associations
    [SystemAccount, Branch, Vehicle,Telephone,Address,Digital,FileSet,ImageSet,LinkSet,SystemAssociation]
  end

end
