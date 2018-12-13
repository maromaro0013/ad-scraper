class WolNikkeibpKijisyuPr
  def self.crawl(target_page)
    helper = CrawlHelper.new

    (1..300).each { |page_count|
      uri = "#{target_page.uri}/page/#{page_count}/"
      break unless crawl_pr_page(target_page, uri, helper)
    }

    helper.destroy
  end

  def self.crawl_pr_page(target_page, page_uri, helper)
    session = helper.session
    session.visit(page_uri)
    ads = session.all("article.article")
    return false if !ads || ads.size <= 0

    begin
      ad_links = ads.map { |ad| ad.find("a.article-link")[:href] }
    rescue
      return false
    end

    ad_links.each { |ad_link|
      next if Ad.find_by(ad_link: ad_link)
      session.visit(ad_link)

      begin
        title = session.find("h1.entry-header-heading").text
        img_link = session.find("div.entry-body.clearfix").first("img")[:src]
      rescue
        title = img_link = ""
      end

      begin
        company = session.find("p", text: /(提供：|提供:).*/).text
      rescue
        begin
          company = session.find("span", text: /(提供：|提供:).*/).text
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

      helper.send_to_chatwork(title, company, ad_link)
    }
    true
  end
end
