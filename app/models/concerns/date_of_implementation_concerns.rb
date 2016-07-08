module DateOfImplementationConcerns extend ActiveSupport::Concern

  included do

    validates_presence_of :date_of_implementation

    searchable do
      time    :date_of_implementation
    end

  end


end