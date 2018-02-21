class BookReleasesCliApp::Book
  attr_accessor :title, :author, :release_date, :price, :url, :type, :overview, :detail_title, :detail_author, :store

  @@all = []

  def initialize(store, attributes)
    attributes.each do |attribute_name, attribute_value|
      self.send("#{attribute_name}=", attribute_value)
    end

    @store = store

    @@all << self
  end #-- initialize --

  def self.all
    @@all

    #puts <<-DOC.gsub /^\s*/, ''
    #  1. The Great Alone  by Kristin Hannah  Available: February 6 2018
    #  2. Girl, Wash Your Face  by Rachel Hollis  Available: February 6 2018
    #  3. Look for Me  by Lisa Gardner  Available: February 6 2018
    #DOC
  end #-- self.all --

  def self.print_book_detail
    all.each.with_index(1) do |book, index|
      puts "[#{index}]. #{book.title} - #{book.author} - #{book.release_date} - #{book.type} #{book.price}"
    end
  end #-- self.print_all --

  def self.print_store_book
    all.each.with_index(1) do |book, index|
      puts "[#{index}]. #{book.title} - #{book.author} - #{book.release_date} - #{book.type} #{book.price}"
    end
  end #-- self.print_all --

  def self.print_all
    all.each.with_index(1) do |book, index|
      puts "[#{index}]. #{book.title} - #{book.author} - #{book.release_date} - #{book.type} #{book.price}"
    end
  end #-- self.print_all --


end #-- BookReleasesCliApp::Book --
