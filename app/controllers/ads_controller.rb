class AdsController < ApplicationController
  def show
    @ad = Ad.find(params[:id])
  end

  def update
    @ad = Ad.find(params[:id])
    if @ad
      if @ad.update(ad_params)
        redirect_to root_path
        flash[:notice] = "testdesu"
      else
        render "show"
      end
    end
  end

  private
    def ad_params
      params.require(:ad).permit(:ad_link, :img_link, :title, :company_name)
    end
end
