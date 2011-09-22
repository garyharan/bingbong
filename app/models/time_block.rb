class TimeBlock < ActiveRecord::Base
  belongs_to :shop

  default_scope :order => "weekday ASC"
end
