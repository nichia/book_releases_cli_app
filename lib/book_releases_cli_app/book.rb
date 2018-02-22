class BookReleasesCliApp::Book
  attr_accessor :title, :author, :release_date, :price, :url, :type, :overview, :detail_title, :detail_author, :store

  @@all = []

  def initialize(store, attributes)
    @store = store

    attributes.each do |attribute_name, attribute_value|
      self.send("#{attribute_name}=", attribute_value)
    end

    @@all << self
  end #-- initialize --

  def self.create_from_book_collection(store, books_array)
    books_array.each do |book|
      self.new(store, book)
    end
  end #-- self.create_from_book_collection --

  def self.all
    @@all
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
