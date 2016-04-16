module UrlValidations extend ActiveSupport::Concern

  included do
    validates_length_of :url ,
                        maximum: 512
  end

end