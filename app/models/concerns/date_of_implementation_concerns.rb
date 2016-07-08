module DateOfImplementationConcerns extend ActiveSupport::Concern

  included do

    searchable do
      time    :date_of_implementation
    end

  end


end