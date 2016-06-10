module NameConcerns
  extend ActiveSupport::Concern

  included do

    validates_presence_of :name

    searchable do
      string :name
      text :name
    end

  end



end