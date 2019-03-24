class Train < ApplicationRecord

  has_many :station_trains
  has_many :stations, :through => :station_trains
  has_many :sales
  belongs_to :train_line

end
