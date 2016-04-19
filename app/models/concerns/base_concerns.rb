module BaseConcerns extend ActiveSupport::Concern

  included do
    before_create{
      self.id = UUIDTools::UUID.timestamp_create().to_s.downcase if id.blank?
    }
    self.primary_key = 'id'

    searchable do

      string :id
      text :id

      time :created_at
      text :created_at

      time :updated_at
      text :updated_at

    end

  end

  module ClassMethods
  end




end