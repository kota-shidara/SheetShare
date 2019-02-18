class Sale < ApplicationRecord

  validates :seller_user_id,          presence: true
  validates :get_on_station_id,       presence: true
  validates :get_off_station_id,      presence: true
  validates :train_id,                presence: true, on: :update
  validates :car_number,              presence: true, on: :update,
                                      numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 15 }
  validates :sheet_type,              presence: true, on: :update
  validates :sheet_number,            presence: true, on: :update
  # validates :seller_user_description, allow_blank: true

  def get_on_station_name
    return Station.find(self.get_on_station_id).name
  end

  def get_off_station_name
    return Station.find(self.get_off_station_id).name
  end

  def train_line_id
    return Station.find(self.get_on_station_id).train_line_id
  end

  def train_line_name
    return TrainLine.find(self.train_line_id).name
  end

  def direction
    if self.get_on_station_id < self.get_off_station_id
      return "上り"
    else
      return "下り"
    end
  end

  def get_on_station_departure_time
    return StationTrain.find_by(train_id: self.train_id, station_id: self.get_on_station_id).departure_time
  end

  def description
    return Train.find(self.train_id).description
  end
end
