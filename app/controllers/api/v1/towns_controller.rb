class Api::V1::TownsController < ApiController
  before_action :find_county, only: [:index]

  def index
    @towns = @county.towns.includes(:roads, :stores)

    render json: @towns, only: [:id, :name]
  end
end