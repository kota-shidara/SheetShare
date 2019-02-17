class Train < ApplicationRecord
  belongs_to :train_line
  has_many :stations, :through => :station_trains
end
