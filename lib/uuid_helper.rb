module UUIDHelper

  def self.included(base)
    base.before_create :assign_uuid
    base.primary_key = 'id'
  end

  private
  def assign_uuid
    self.id = UUIDTools::UUID.timestamp_create().to_s.downcase if id.blank?
  end

end