class TargetPagesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    target_page = TargetPage.new(target_page_params)

    if target_page.save
      render json: target_page
    else
      render json: {}
    end
  end

  private
    def target_page_params
      params.require(:target_page).permit(:name, :uri, :target_site_id)
    end
end
