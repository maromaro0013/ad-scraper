class CrawlAdJob < ApplicationJob
  queue_as :crawl_ad

  def perform(*args)
    TargetPage.find_each { |page| page.crawl }
    after = (DateTime.current + 1.hour).change(min: 0)
    CrawlAdJob.set(wait_until: after).perform_later
  end
end
