class TrainLine < ApplicationRecord
  has_many :trains
  has_many :stations
end
