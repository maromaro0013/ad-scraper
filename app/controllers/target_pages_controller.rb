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

  def add_crawl_method
    id = params[:id]
    crawl_method_id = target_page_params[:crawl_method_id]
    target_page = TargetPage.find(id)
    if target_page
      if CrawlMethod.find(crawl_method_id)
        target_page.add_crawl_method(crawl_method_id)
        render json: "", status: 200
      else
        render json: "", status:404
      end
    else
      render json: "", status:404
    end
  end

  private
    def target_page_params
      params.require(:target_page).permit(:name, :uri, :target_site_id, :crawl_method_id)
    end
end
