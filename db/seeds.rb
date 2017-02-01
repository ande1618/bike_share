require 'csv'
require 'pry-rescue'
require 'pry-stack_explorer'
require './app/models/weather.rb'
require './app/models/station.rb'
require './app/models/trip.rb'
require './app/models/city.rb'
require './app/models/subscription.rb'
require './app/models/bike.rb'
require 'activerecord-import'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'

# file = './db/csv/station.csv'
# csv_text = File.read(file)
# csv = CSV.parse(csv_text, :headers => true)
# Pry::rescue{csv.each do |row|
#   Station.create!(name: row[1], dock_count: row[4],
#                   city: City.find_or_create_by(name: row[5]),
#                   installation_date: row[6])
#
# end}

trips = []
Pry::rescue{CSV.foreach('db/csv/trip.csv', headers: true) do |row|
  start_date = row[2][0..8]
  end_date = row[5][0..8]
  trips << Trip.new(
      duration:           row[1],
      start_date:         start_date,
      start_station_id:   Station.find_by(name: row[3]).id,
      end_date:           end_date,
      end_station_id:     Station.find_by(name: row[6]).id,
      bike_id:            Bike.find_or_create_by(serial_no: row[8]).id,
      subscription_id:    Subscription.find_or_create_by(kind: row[9]).id,
      zip_code:           row[10]
                    )
  if trips.size == 10000
    Trip.import trips
    trips = []
  end
end}
#
# weather = []
# Pry::rescue{CSV.foreach('db/csv/weather.csv', headers: true) do |row|
#   date = row[0]strftime('%m/%d/%Y')
#   weather << Weather.new(
#       date:                   date,
#       max_temp:               row[1],
#       mean_temp:              row[2],
#       mean_humidity:          row[8],
#       mean_visibility_miles:  row[14],
#       mean_wind_speed:        row[17],
#       precipitation:          row[19],
#       trip_id:                Trip.find_by(start_date: row[0]).id
#                               )
#   if weather.size == 10000
#     Weather.import weather
#     weather = []
#   end
# end}
