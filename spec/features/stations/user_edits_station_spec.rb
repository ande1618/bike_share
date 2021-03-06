require 'spec_helper'

describe "when a user edits current station" do
  it "they can click update information for a station" do
    city = City.create(name:'SanDiego')
    Station.create(name: 'test', dock_count: 3, city_id: '1', installation_date: '11/07/1997')

    visit "/stations/1/edit"

    fill_in "station[name]", :with => "SF1"
    fill_in "station.city[name]", :with => "Denver"
    fill_in "station[dock_count]", :with => 111
    fill_in "station[installation_date]", :with => "2013-08-06"

    click_on("Update Station")
    city = City.create(name:'SanDiego')    
    station = Station.create(name: 'SF1', dock_count: 3, city_id: '1', installation_date:"2013-08-06")
    expect(page).to have_current_path "/stations/1"

    within ("#heading") do
    expect(page).to have_content ("SF1")
    end
    within ("#table1") do
    expect(page).to have_content "SanDiego"
    expect(page).to have_content "111"
    expect(page).to have_content "2013-08-06"
    end
  end
end
