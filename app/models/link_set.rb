class LinkSet < ActiveRecord::Base

  include BaseConcerns,
          Url,
          RelLinkSet

  belongs_to :linksetable, polymorphic: true

end
