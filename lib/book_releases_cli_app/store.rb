class InvalidType < StandErro; end

class BookReleasesCliApp::Store
  attr_accessor :name, :url
  #attr_reader :books

  def initialize
    @books = []
  end #-- initialize --

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


end #-- BookReleasesCliApp::Store --
