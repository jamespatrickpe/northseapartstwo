class Digital < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          UrlValidations

  belongs_to :digitable, polymorphic: true

end
