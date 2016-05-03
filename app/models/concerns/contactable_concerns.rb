module ContactableConcerns extend ActiveSupport::Concern

  included do

    has_many :contact_details, as: :contactable
    has_many :telephones, through: :contact_details
    has_many :digitals, through: :contact_details
    has_many :addresses, through: :contact_details

  end
end