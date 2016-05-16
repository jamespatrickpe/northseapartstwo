module NameConcerns
  extend ActiveSupport::Concern

  included do

    validates :name, uniqueness: true
    validates_presence_of :name

    searchable do
      string :name
      text :name
    end

  end



end