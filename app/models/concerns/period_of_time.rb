module PeriodOfTime
  extend ActiveSupport::Concern

  included do
    validates_presence_of :period_of_time,
                          maximum: 64
  end

end