class ApiController < ActionController::Base
  def find_county
    @county = County.all.find(params[:county_id])
  end

  def find_town
    @town = @county.towns.find(params[:town_id]) 
  end

  def find_road
    @road = @town.roads.find(params[:road_id])
  end
end