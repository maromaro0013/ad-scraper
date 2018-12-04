class TargetSitesController < ApplicationController
  protect_from_forgery except: [:create]

  def index
    respond_to { |format|
      format.html
      format.json { render json: TargetSite.all }
    }
    @target_sites = TargetSite.all
  end

  def show
    @target_site = TargetSite.find(params[:id])
  end

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
