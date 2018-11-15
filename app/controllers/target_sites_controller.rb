class TargetSitesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    target_site = TargetSite.new(target_site_params)

    if target_site.save
      render json: target_site
    else
      render json: {}
    end
  end

  private
    def target_site_params
      params.require(:target_site).permit(:name, :domain)
    end
end
