module UrlConcerns extend ActiveSupport::Concern

  included do
    validates_length_of :url ,
                        maximum: 512

    searchable do
      string :url
      text :url
    end


  end


end