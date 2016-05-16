module AssociatedFilesConcerns
  extend ActiveSupport::Concern

  included do

    has_many :system_association, as: :model_one
    has_many :system_association, as: :model_two

  end

end