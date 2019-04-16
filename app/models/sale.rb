class Sale < ApplicationRecord

  belongs_to :train

  validates :seller_user_id,          presence: true
  validates :get_on_station_id,       presence: true
  validates :get_off_station_id,      presence: true
  validates :train_id,                presence: true, on: :update
  validates :car_number,              presence: true, on: :update,
                                      numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 15 }
  validates :sheet_type,              presence: true, on: :update
  validates :sheet_number,            presence: true, on: :update
  # validates :seller_user_description, allow_blank: true

  # get_on_stationとget_off_stationが同じものであったときのvalidationをまだかけてい

  SALE_STATUS = [:selling, :matched, :finished].freeze

  def get_on_station
    return Station.find(self.get_on_station_id)
  end

  def get_off_station
    return Station.find(self.get_off_station_id)
  end

  def train_line
    TrainLine.find(Station.find(self.get_on_station_id).train_line_id)
  end

  def direction_by_get_on_and_off_station
    if self.get_on_station_id < self.get_off_station_id
      return "上り"
    else
      return "下り"
    end
  end

  def is_matched?
    self.buyer_user_id.present?
  end

  # 乗車時刻の時刻部分だけを取っているので直したい
  def is_finished?
    !self.created_at.today? || self.get_off_station_departure_time.hour < Time.now.hour
  end

  def sale_status
    num = 0
    if is_matched?
      num = 1
    elsif is_finished?
      num = 2
    end
    SALE_STATUS[num]
  end

  def get_on_station_departure_time
    StationTrain.find_by(train_id: self.train_id, station_id: self.get_on_station_id).departure_time
  end

  def get_off_station_departure_time
    StationTrain.find_by(train_id: self.train_id, station_id: self.get_off_station_id).departure_time
  end

  def description
    return Train.find(self.train_id).description
  end
end
