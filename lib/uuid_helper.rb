module UUIDHelper
  def self.included(base)
    base.primary_key = 'id'
    base.before_create :assign_uuid
  end

  private
  def assign_uuid
    self.id = UUIDTools::UUID.timestamp_create().to_s.downcase if id.blank?
  end
end