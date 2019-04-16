require "csv"

train_line_data = CSV.read('etc/train_line.csv', headers: true)
train_line_data.each do |data|
  TrainLine.create(data.to_hash)
end

train_data = CSV.read('etc/train.csv', headers: true)
train_data.each do |data|
  Train.create(data.to_hash)
end

station_data = CSV.read('etc/station.csv', headers: true)
station_data.each do |data|
  Station.create(data.to_hash)
end

station_train_data = CSV.read('etc/station_train.csv', headers: true)
station_train_data.each do |data|
  StationTrain.create(data.to_hash)
end