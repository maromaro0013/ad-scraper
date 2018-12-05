namespace :ad_scraper do
  desc "clear sidekiq running jobs"
  task clear_running_jobs: :environment do
    Sidekiq::Queue.new("crawl_ad").clear
  end
end
