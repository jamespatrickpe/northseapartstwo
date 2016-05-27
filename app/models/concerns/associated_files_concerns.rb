module AssociatedFilesConcerns
  extend ActiveSupport::Concern

  included do

    has_many :system_association, as: :model_one, dependent: :destroy
    has_many :system_association, as: :model_two, dependent: :destroy

  end

end