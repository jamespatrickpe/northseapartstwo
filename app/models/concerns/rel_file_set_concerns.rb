module RelFileSetConcerns
  extend ActiveSupport::Concern

  included do
    belongs_to :rel_file_set,
               polymorphic: true
  end

end