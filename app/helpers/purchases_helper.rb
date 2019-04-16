module PurchasesHelper
  def time_at_near_station(sale, near_station)
    StationTrain.find_by(train_id: sale.train_id, station_id: @near_station.id).departure_time.strftime('%H:%M')
  end
end
