module RemarkConcerns extend ActiveSupport::Concern

  included do

    validates_length_of :remark,
                        maximum: 256,
                        message: "remark must be less than 256 characters"

    searchable do
      text :remark
    end

  end


end