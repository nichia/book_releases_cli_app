class BookReleasesCliApp::NewBooks
  attr_accessor :title, :author, :release_date, :price, :url, :type, :overview

  def self.all

    #puts <<-DOC.gsub /^\s*/, ''
    #  1. The Great Alone  by Kristin Hannah  Available: February 6 2018
    #  2. Girl, Wash Your Face  by Rachel Hollis  Available: February 6 2018
    #  3. Look for Me  by Lisa Gardner  Available: February 6 2018
    #DOC

    self.scraper

  end

  def self.scraper
    newbooks = []

    base_url = "http://www.booksamillion.com/"
    comingsoon_page = "comingsoon?mobile=no&DDTN=Books&DDLN=Coming-Soon&id=7171783864562"
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

      details = self.scrape_details(newbook.url)

      newbook.release_date = details[:release_date]
      newbook.overview = details[:overview]

      newbooks << newbook
      #binding.pry
    end

    #binding.pry

    newbooks
  end

  def self.scrape_details(url)
    details = {}

    main_url = url

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    #doc.css("div.inner-content-container")
    #binding.pry

    details = {
      :overview => doc.css("span.details-content-text").text,
      :release_date => doc.css("div.details-content-text li")[3].text.gsub("Publish Date: ", "")
    }
    #details << {date: date, overview: overview}
  end
end
