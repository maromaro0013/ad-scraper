module WolNikkeibpColumn
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

    session.visit(target_page.uri)
    ads = session.all("div.logly-lift-ad-adv")

    return if !ads || ads.size <= 0
    ads.each { |ad|
      company = ad.text
      next unless company.index("PR（")

      title = ad.find(:xpath, "..").all("div.logly-lift-ad-title")[0].text
      style = ad.find(:xpath, "../../..").find("div.logly-lift-ad-img-inner")[:style]
      image = style.split("\"")[1].gsub("//", "")
      link = ad.find(:xpath, "../../../../..").find("a.logly-lift-ad-link")[:href]

      record = self.find_or_initialize_by(target_site_id: target_page.id, title: title)
      record.update(
        ad_link: link,
        img_link: image,
        title: title,
        company_name: company,
        target_site_id: target_page.target_site_id,
        target_page_id: target_page.id
      )
    }
  end
end
