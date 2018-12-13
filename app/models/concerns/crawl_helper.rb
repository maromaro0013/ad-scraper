class CrawlHelper
  attr_accessor :session

  def initialize
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, {
        browser: :chrome,
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
          chrome_options: { args: %w(headless disable-gpu window-size=1680,1050) }
        )
      })
    end

    Capybara.javascript_driver = :selenium
    @session = Capybara::Session.new(:selenium)
  end

  def send_to_chatwork(title, company, ad_link)
    chatwork = ChatWork::Client.new(api_key: ENV["CHATWORK_API_KEY"])
    msg = "Title: #{title}\nCompany Name: #{company}\nLink: #{ad_link}"
    url = ENV["AD_SCRAPER_URL"]
    chatwork.create_message(
      room_id: ENV["CHATWORK_ROOM_ID"],
      body: "[info][title]#{url} - scraping new ad [/title]#{msg}[/info]"
    )
  end

  def destroy
    @session.driver.browser.close
    @session.driver.quit
  end
end
