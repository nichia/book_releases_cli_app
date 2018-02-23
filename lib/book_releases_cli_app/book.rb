class BookReleasesCliApp::Book
  attr_accessor :title, :author, :release_date, :price, :url, :type, :overview, :detail_title, :detail_author, :store

  @@all = []

  def initialize(store, attributes)
    @store = store

    attributes.each do |attribute_name, attribute_value|
      self.send("#{attribute_name}=", attribute_value)
    end

  end #-- initialize --

  def self.create_from_book_collection(store, books_array)

    books = books_array.collect do |book_hash|
      book = self.new(store, book_hash)
      book.save
      book
    end

  end #-- self.create_from_book_collection --

  def save
    @@all << self
  end # save instance --

  def self.all
    @@all
  end #-- self.all --

  def store=(store)
    # Assign that store to myself

    binding.pry
    @store = store

    # Creates a reciprocal belongs to
    # Tell the store that it has a new book (self)
    store.add_book(self)
  end #-- store writter --

  def self.print_book_detail
    all.each.with_index(1) do |book, index|
      puts "[#{index}]. #{book.title} - #{book.author} - #{book.release_date} - #{book.type} #{book.price}"
    end
  end #-- self.print_all --

  def self.print_books_by_store
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
