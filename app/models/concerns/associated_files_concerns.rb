module AssociatedFilesConcerns
  extend ActiveSupport::Concern

  included do

    has_many :system_association, as: :model_one, dependent: :destroy
    has_many :system_association, as: :model_two, dependent: :destroy

    has_many :file_sets, as: :filesetable, dependent: :destroy
    has_many :image_sets, as: :imagesetable, dependent: :destroy
    has_many :link_set, as: :linksetable, dependent: :destroy

  end

end