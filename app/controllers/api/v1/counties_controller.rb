class Api::V1::CountiesController < ApiController
  def index
    @counties = County.includes(:towns, :stores).all

    render json: @counties, only: [:id, :name]
  end

  def show
    @county = County.all.find(params[:id])
    @towns_in_county = @county.towns

    render json: @towns_in_county, only: [:id, :name]
  end
end