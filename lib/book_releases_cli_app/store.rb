class InvalidType < StandErro; end

class BookReleasesCliApp::Store
  attr_accessor :name, :books
  #attr_reader :books

  def initialize(name, books_array)
    @name = name

    @books = books_array.collect do |book_attributes|
      Book.new(self, book_attributes)
    end

    @@all << self
  end #-- initialize --

  def self.find(id)
    @@all[id.to_i - 1]
  end #-- self.find --

  def books
    @books.dup.freeze
  end #-- books reader --

  def add_book(book)
    if !book.is_a?(Book)
      raise InvalidType, "Must be a Book"
    else
      @books << book
    end
  end #-- add_book --

  def find_book(id)
    self.books[id.to_i - 1]
  end #-- self.find_book --

  def self.all
    @@all
  end #-- self.all --

  def self.print_all
    all.each_with_index(1) do |store, index|
      puts "[#{index}].  #{store.name}"
    end
  end #-- self.print_all

end #-- BookReleasesCliApp::Store --
