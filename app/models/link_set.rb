class LinkSet < ActiveRecord::Base

  include BaseConcerns,
          UrlConcerns,
          RelLinkSetConcerns

  belongs_to :linksetable, polymorphic: true

end
