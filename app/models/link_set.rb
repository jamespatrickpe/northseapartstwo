class LinkSet < ActiveRecord::Base

  include BaseConcerns,
          UrlValidations,
          RelLinkSetValidations

end
