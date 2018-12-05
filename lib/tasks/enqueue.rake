namespace :ad_scraper do
  desc "enqueue"
  task enqueue: :environment do
    CrawlAdJob.set.perform_later
  end
end
