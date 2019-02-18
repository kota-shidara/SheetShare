class Station < ApplicationRecord
  belongs_to :train_line
  has_many :trains, :through => :station_trains
end
