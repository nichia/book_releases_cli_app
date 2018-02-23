class InvalidType < StandardError; end

class BookReleasesCliApp::Store
  attr_accessor :name
  attr_reader :books

  @@all = []

  def initialize(name, books_array)
    @name = name

    @books = BookReleasesCliApp::Book.create_from_book_collection(self, books_array)
    #@books = books_array.collect do |book_attributes|
    #  BookReleasesCliApp::Book.new(self, book_attributes)
    #end

    @@all << self
  end #-- initialize --

  def self.find(id)
    @@all[id.to_i - 1]
  end #-- self.find (store-id)--

  def books
    @books.dup.freeze
  end #-- books reader --

  def add_book(book)
    if !book.is_a?(Book)
      raise InvalidType, "Must be a Book"
    else
      @books << book unless books.include?(book)
      book.store = self unless book.store == self
    end
    binding.pry
  end #-- add_book --

  def find_book(id)
    self.books[id.to_i - 1]
  end #-- self.find_book --

  def self.all
    @@all
  end #-- self.all --

  def self.print_all
    all.each.with_index(1) do |store, index|
      puts "[#{index}]. #{store.name}"
    end
  end #-- self.print_all

end #-- BookReleasesCliApp::Store --
