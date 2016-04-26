module RelModelConcerns
  extend ActiveSupport::Concern

  included do
    belongs_to :rel_model,
               polymorphic: true
    validates_presence_of :rel_model
  end

end