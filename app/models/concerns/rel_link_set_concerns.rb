module RelLinkSetConcerns
  extend ActiveSupport::Concern

  included do
    belongs_to :rel_link_set,
               polymorphic: true
  end

end