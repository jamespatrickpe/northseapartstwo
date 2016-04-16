class Digital < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          UrlValidations,
          BelongsRelModel

end
