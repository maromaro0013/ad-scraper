class WolNikkeibpKijisyuPr
  def self.crawl(target_page)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, {
        browser: :chrome,
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
          chrome_options: { args: %w(headless disable-gpu window-size=1680,1050) }
        )
      })
    end

    Capybara.javascript_driver = :selenium
    session = Capybara::Session.new(:selenium)

    (1..300).each { |page_count|
      uri = "#{target_page.uri}/page/#{page_count}/"
      break unless crawl_pr_page(target_page, uri, session)
    }

    session.driver.browser.close
    session.driver.quit
  end

  def self.crawl_pr_page(target_page, page_uri, session)
    session.visit(page_uri)
    ads = session.all("article.article")
    return false if !ads || ads.size <= 0

    begin
      ad_links = ads.map { |ad| ad.find("a.article-link")[:href] }
    rescue
      return false
    end

    is_new_ad = false
    ad_links.each { |ad_link|
      next if Ad.find_by(ad_link: ad_link)
      session.visit(ad_link)

      title = session.find("h1.entry-header-heading").text
      img_link = session.find("div.entry-body.clearfix").first("img")[:src]
      begin
        company = session.find("p", text: /提供：.*/).text
      rescue
        begin
          company = session.find("span", text: /提供:.*/).text
        rescue
          company = ""
        end
      end

      record = Ad.find_or_create_by(
        ad_link: ad_link,
        img_link: img_link,
        title: title,
        company_name: company,
        target_site_id: target_page.target_site_id,
        target_page_id: target_page.id
      )

      chatwork = ChatWork::Client.new(api_key: ENV["CHATWORK_API_KEY"])
      msg = "Title: #{title}\nCompany Name: #{company}\nLink: #{ad_link}"
      url = ENV["AD_SCRAPER_URL"]
      chatwork.create_message(
        room_id: ENV["CHATWORK_ROOM_ID"],
        body: "[info][title]#{url} - scraping new ad [/title]#{msg}[/info]"
      )

      is_new_ad = true
    }

    is_new_ad
  end
end
