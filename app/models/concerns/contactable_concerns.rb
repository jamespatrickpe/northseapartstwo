module ContactableConcerns extend ActiveSupport::Concern

  included do

    has_many :addresses, as: :addressable
    has_many :telephones, as: :telephonable
    has_many :digitals, as: :digitable

  end

end