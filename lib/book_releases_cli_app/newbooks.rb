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

      newbook.release_date = details[0]
      newbook.overview = details[1]

      newbooks << newbook
      binding.pry
    end

    #binding.pry

    newbooks
  end

  def self.scrape_details(url)
    details = []

    main_url = url

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    #doc.css("div.inner-content-container")
    #binding.pry

    overview = doc.css("span.details-content-text").text
    date = doc.css("div.details-content-text li")[3].text.gsub("Publish Date: ", "")

    details << {date: date, overview: overview}
  end

    #newbooks_1 = self.new
    #newbooks_1.title = "The Great Alone"
    #newbooks_1.author = "Kristin Hannah"
    #newbooks_1.release_date = "February 6 2018"
    #newbooks_1.price = "$10"
    #@@all << newbooks_1

    #newbooks_2 = self.new
    #newbooks_2.title = "Girl, Wash Your Face"
    #newbooks_2.author = "Rachel Hollis"
    #newbooks_2.release_date = "February 6 2018"
    #newbooks_2.price = "$15"
    #@@all << newbooks_2

    #newbooks_3 = self.new
    #newbooks_3.title = "Look for Me"
    #newbooks_3.author = "Lisa Gardner"
    #newbooks_3.release_date = "February 6 2018"
    #newbooks_3.price = "$20"
    #@@all << newbooks_3

end
