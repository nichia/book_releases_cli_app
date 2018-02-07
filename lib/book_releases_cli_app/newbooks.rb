class BookReleasesCliApp::NewBooks
  attr_accessor :title, :author, :release_date, :price, :url, :type

  def self.all

    #puts <<-DOC.gsub /^\s*/, ''
    #  1. The Great Alone  by Kristin Hannah  Available: February 6 2018
    #  2. Girl, Wash Your Face  by Rachel Hollis  Available: February 6 2018
    #  3. Look for Me  by Lisa Gardner  Available: February 6 2018
    #DOC

    self.scrape_newbooks
  end

  def self.scrape_newbooks
    newbooks = []

    newbooks << self.scrape_bam

    newbooks
  end

  def self.scrape_bam
    html = open('http://www.booksamillion.com/comingsoon?mobile=no&DDTN=Books&DDLN=Coming-Soon&id=7171783864562')
    doc = Nokogiri::HTML(html)
    doc.search("div#content .product-list .experiments-module-content-display").each do |product|
      url = product.search("a").attr("href").value
      author = product.search("span")[0].text
      title = product.search("a strong")[0].text
      price = product.search("a strong")[1].text
      type = product.search("span")[1].text
      binding.pry
    end
  end

    #newbook_1 = self.new
    #newbook_1.title = "The Great Alone"
    #newbook_1.author = "Kristin Hannah"
    #newbook_1.release_date = "February 6 2018"
    #newbook_1.price = "$10"
    #@@all << newbook_1

    #newbook_2 = self.new
    #newbook_2.title = "Girl, Wash Your Face"
    #newbook_2.author = "Rachel Hollis"
    #newbook_2.release_date = "February 6 2018"
    #newbook_2.price = "$15"
    #@@all << newbook_2

    #newbook_3 = self.new
    #newbook_3.title = "Look for Me"
    #newbook_3.author = "Lisa Gardner"
    #newbook_3.release_date = "February 6 2018"
    #newbook_3.price = "$20"
    #@@all << newbook_3

end
