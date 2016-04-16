class LinkSet < ActiveRecord::Base

  include BaseConcerns,
          UrlValidations,
          RelLinkSetValidations

  belongs_to :linksetable, polymorphic: true

end
