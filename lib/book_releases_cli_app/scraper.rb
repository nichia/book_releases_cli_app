class BookReleasesCliApp::Scraper
  #attr_accessor :store
  #attr_reader :doc


  #def initialize(name)
  #  @store = Store.new
  #  @store.name = name
  #  @doc =
  #end #--

  def self.bn_scraper
    newbooks = []

    base_url = "https://www.barnesandnoble.com"
    comingsoon_page = "/b/coming-soon/_/N-1oyfZ8q8"
    main_url = "#{base_url}#{comingsoon_page}"

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    doc.css("div#main-content div.product-shelf-info").collect do |product|
      #newbook = Book.new

      title_url = product.css(".product-shelf-title a").attr("href").text.split(";")[0]
      session_url = product.css(".product-shelf-title a").attr("href").text.split("?").last


      book_details = self.bn_scrape_details("#{base_url}#{title_url}?#{session_url}")

      book_info = {
        :url => "#{base_url}#{title_url}?#{session_url}",
        :title => product.css(".product-shelf-title a").text,
        :author => product.css(".product-shelf-author").text.gsub("\n\nby ", ""),
        :detail_title => book_details[:detail_title],
        :detail_author => book_details[:detail_author],
        :type => book_details[:detail_type],
        :price => book_details[:detail_price],
        :release_date => book_details[:release_date],
        :overview => book_details[:overview]
      }
      #binding.pry
      #newbooks << newbook
    end

    #newbooks
  end #-- self.bn_scraper --

  def self.bn_scrape_details(url)
    details = {}

    main_url = url

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    #doc.css("div#hero-section-placeholder")
    #binding.pry

    bformat = doc.css("section.formatSelect").text.gsub("\n", "").split(" - ") [0]
    bprice = doc.css("section.formatSelect").text.gsub( / *\n+/, " - " ).split(" - ")[2]
    if bformat == ""
      bformat = doc.css("div#prodPromo h2#pdp-info-format").text.gsub("\n", "")
      bprice = doc.css("div#prodPromo span#pdp-cur-price").text
    end

    details = {
      :detail_title => doc.css("header#prodSummary-header h1").text,
      :detail_author => doc.css("header#prodSummary-header span a").text,
      :detail_type => bformat,
      :detail_price => bprice,
      :release_date => doc.css("div#ProductDetailsTab td")[2].text,
      #:release_date => doc.css("div#commerce-zone li")[0].text.gsub(" This item will be available on ", "").split("\n")[2],
      :overview => doc.css("div#productInfoOverview p").text.gsub(/\s+/, " ")
    }
  end #-- self.bn_scrape_details(url) --


  def self.bam_scraper

    base_url = "http://www.booksamillion.com"
    comingsoon_page = "/comingsoon?mobile=no&DDTN=Books&DDLN=Coming-Soon&id=7171783864562"
    main_url = "#{base_url}#{comingsoon_page}"

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    doc.css("div#content .product-list .experiments-module-content-display").collect do |product|

      book_url = product.css("a").attr("href").value

      book_details = self.bam_scrape_details(book_url)

      book_info = {
        :url => book_url,
        :title => product.css("a strong")[0].text,
        :author => product.css("span")[0].text,
        :detail_title => book_details[:detail_title],
        :detail_author => book_details[:detail_author],
        :type => product.css("span")[1].text,
        :price => product.css("a strong")[1].text,
        :release_date => book_details[:release_date],
        :overview => book_details[:overview]
      }
    end
  end #-- self.bam_scraper --

  #newbooks = []

    #doc.css("div#content .product-list .experiments-module-content-display").each do |product|
    #  newbook = Book.new

    #  newbook.url = product.css("a").attr("href").value
    #  newbook.title = product.css("a strong")[0].text
    #  newbook.author = product.css("span")[0].text
    #  newbook.type = product.css("span")[1].text
    #  newbook.price = product.css("a strong")[1].text

    #  details = self.bam_scrape_details(newbook.url)

    #  newbook.detail_title = details[:detail_title]
    #  newbook.detail_author = details[:detail_author]
    #  newbook.release_date = details[:release_date]
    #  newbook.overview = details[:overview]

      #binding.pry
    #  newbooks << newbook
    #end

    #newbooks

  def self.bam_scrape_details(url)
    details = {}

    main_url = url

    html = open(main_url)
    doc = Nokogiri::HTML(html)

    #doc.css("div.inner-content-container")
    #binding.pry

    details = {
      :detail_title => doc.css("div#details-description-container div span.details-title-text")[0].text,
      :detail_author => doc.css("div#details-description-container div span.details-author-text").text.gsub("by ", "").gsub("- ", "").gsub("\n",""),
      :release_date => doc.css("div#details-description-container div.price-block-quote-text strong")[0].text.gsub("This item will ship on ", "").split(".")[0],
      :overview => doc.css("span.details-content-text").text.gsub(/\s+/, " ")
    }
  end #-- self.bam_scrape_details(url) --

end #--  BookReleasesCliApp::Scraper --
