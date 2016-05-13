class LinkSet < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns
          UrlConcerns

  belongs_to :linksetable, polymorphic: true

  searchable do
    text :linksetable do
      polymorphic_searchable_representation(linksetable)
    end
  end

end
