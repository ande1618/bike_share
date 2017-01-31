class Trip < ActiveRecord::Base
  validates :duration, :start_station_id, :start_date, :end_station_id, :end_date, :bike_id, :subscription_id, presence: true
  belongs_to :subscription
  belongs_to :bike, class_name: 'Bike', foreign_key: 'bike_id'
  belongs_to :start_station, class_name: 'Station', foreign_key: 'start_station_id'
  belongs_to :end_station, class_name: 'Station', foreign_key: 'end_station_id'
end

def self.most_ridden_bike
  @trips.group('bike_id').order('count(*)').pluck(:bike_id).first
end

def self.least_ridden_bike
  @trips.group('bike_id').order('count(*)').pluck(:bike_id).last
end

def self.subscriber_count
  @trips.where("subscription_id = '1'").count
end

def self.customer_count
  @trips.where("subscription_id = '2'").count
end

def self.subscriber_breakout
  "#{(subscriber_count / customer_count) * 100} %"
end

def self.most_common_date
  trips.group('start_date').order('count(*)').pluck(:start_date).first
end

def self.most_common_date_count
  trips.where(start_date: '#{most_common_date}').count
end

def self.least_common_date
  trips.group('start_date').order('count(*)').pluck(:start_date).last
end

def self.least_common_date_count
  trips.where(start_date: '#{least_common_date}').count
end
