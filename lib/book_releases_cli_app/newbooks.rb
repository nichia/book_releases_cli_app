class BookReleasesCliApp::NewBooks
  attr_accessor :title, :author, :release_date, :price, :url, :type, :overview, :detail_title, :detail_author

  def self.all

    #puts <<-DOC.gsub /^\s*/, ''
    #  1. The Great Alone  by Kristin Hannah  Available: February 6 2018
    #  2. Girl, Wash Your Face  by Rachel Hollis  Available: February 6 2018
    #  3. Look for Me  by Lisa Gardner  Available: February 6 2018
    #DOC
    self.bam_scraper
  end #-- self.all --

  def self.bn_scraper
    newbooks = []

    base_url = "https://www.barnesandnoble.com"
    comingsoon_page = "/b/coming-soon/_/N-1oyfZ8q8"
    main_url = "#{base_url}#{comingsoon_page}"

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    doc.css("div#main-content div.product-shelf-info").each do |product|
      newbook = self.new

      title_url = product.css(".product-shelf-title a").attr("href").text.split(";")[0]
      session_url = product.css(".product-shelf-title a").attr("href").text.split("?").last

      newbook.url = "#{base_url}#{title_url}?#{session_url}"
      newbook.title = product.css(".product-shelf-title a").text
      newbook.author = product.css(".product-shelf-author").text.gsub("\n\nby ", "")

      details = self.bn_scrape_details(newbook.url)

      newbook.release_date = details[:release_date]
      newbook.overview = details[:overview]
      newbook.detail_title = details[:detail_title]
      newbook.detail_author = details[:detail_author]
      newbook.type = details[:detail_type]
      newbook.price = details[:detail_price]

      #binding.pry
      newbooks << newbook
    end

    newbooks
  end #-- self.bn_scraper --

  def self.bn_scrape_details(url)
    details = {}

    main_url = url

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    #doc.css("div#hero-section-placeholder")
    #binding.pry

    details = {
      :detail_price => doc.css("div#prodPromo span#pdp-cur-price").text,
      :detail_type => doc.css("div#prodPromo h2#pdp-info-format").text.gsub("\n", ""),
      :overview => doc.css("div#productInfoOverview p").text.gsub(/\s+/, " "),
      :release_date => doc.css("div#commerce-zone li")[0].text.gsub(" This item will be available on ", "").split("\n")[2],
      :detail_title => doc.css("header#prodSummary-header h1").text,
      :detail_author => doc.css("header#prodSummary-header span a").text
    }
  end #-- self.bn_scrape_details(url) --


  def self.bam_scraper
    newbooks = []

    base_url = "http://www.booksamillion.com"
    comingsoon_page = "/comingsoon?mobile=no&DDTN=Books&DDLN=Coming-Soon&id=7171783864562"
    main_url = "#{base_url}#{comingsoon_page}"

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    doc.css("div#content .product-list .experiments-module-content-display").each do |product|
      newbook = self.new
      newbook.url = product.css("a").attr("href").value
      newbook.author = product.css("span")[0].text
      newbook.title = product.css("a strong")[0].text
      newbook.price = product.css("a strong")[1].text
      newbook.type = product.css("span")[1].text

      details = self.bam_scrape_details(newbook.url)

      newbook.release_date = details[:release_date]
      newbook.overview = details[:overview]
      newbook.detail_title = details[:detail_title]
      newbook.detail_author = details[:detail_author]

      #binding.pry
      newbooks << newbook
    end

    newbooks
  end #-- self.bam_scraper --

  def self.bam_scrape_details(url)
    details = {}

    main_url = url

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    #doc.css("div.inner-content-container")
    #binding.pry

    details = {
      :overview => doc.css("span.details-content-text").text.gsub(/\s+/, " "),
      :release_date => doc.css("div#details-description-container div.price-block-quote-text strong")[0].text.gsub("This item will ship on ", "").split(".")[0],
      :detail_title => doc.css("div#details-description-container div span.details-title-text")[0].text,
      :detail_author => doc.css("div#details-description-container div span.details-author-text").text.gsub("by ", "").gsub("- ", "").gsub("\n","")
    }
  end #-- self.bam_scrape_details(url) --

end #-- BookReleasesCliApp::NewBooks --
