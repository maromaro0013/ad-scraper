class AdsController < ApplicationController
  def show
    @ad = Ad.find(params[:id])
  end

  private
    def ad_params
      params.require(:ad).permit(:ad_link, :img_link, :title, :company_name)
    end
end
