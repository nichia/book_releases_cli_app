class BookReleasesCliApp::CLI

  def call
    list_books
    menu
  end

  def list_books
    puts "New Book Releases"

    newbooks = BookReleasesCliApp::NewBooks.all
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the book number for more information or type list to see the books again or type exit"
      input = gets.strip.downcase
      case input
      when "1"
        puts "More info on book 1"
      when "2"
        puts "More info on book 2"
      when "3"
        puts "More info on book 3"
      when "list"
        list_books
      when "exit"
        puts "Thank you for using New Book Releases application"
      else
        puts "Incorrect enty, type list or exit"
      end
    end
  end

end
