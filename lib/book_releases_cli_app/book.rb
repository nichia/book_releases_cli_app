class BookReleasesCliApp::Book
  attr_accessor :title, :author, :release_date, :price, :url, :type, :overview, :detail_title, :detail_author

  def self.all

    #puts <<-DOC.gsub /^\s*/, ''
    #  1. The Great Alone  by Kristin Hannah  Available: February 6 2018
    #  2. Girl, Wash Your Face  by Rachel Hollis  Available: February 6 2018
    #  3. Look for Me  by Lisa Gardner  Available: February 6 2018
    #DOC
    self.bam_scraper
  end #-- self.all --


end #-- BookReleasesCliApp::Book --
