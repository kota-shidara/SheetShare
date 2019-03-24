class Station < ApplicationRecord

  has_many :station_trains
  has_many :trains, :through => :station_trains
  has_many :sales
  belongs_to :train_line

end
