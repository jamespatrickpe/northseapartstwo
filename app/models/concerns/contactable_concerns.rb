module ContactableConcerns extend ActiveSupport::Concern

  included do

    has_many :addresses, as: :addressable, dependent: :destroy
    has_many :telephones, as: :telephonable, dependent: :destroy
    has_many :digitals, as: :digitable, dependent: :destroy

  end

end