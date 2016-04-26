module BaseConcerns extend ActiveSupport::Concern

  included do
    before_create{
      self.id = UUIDTools::UUID.timestamp_create().to_s.downcase if id.blank?
    }
    self.primary_key = 'id'

    searchable do
      string :id
      text :id, :created_at, :updated_at
      time :created_at, :updated_at
    end

  end

  module ClassMethods


  end




end