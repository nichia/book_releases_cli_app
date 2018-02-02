class BookReleasesCliApp::CLI

  def call
    list_books
    menu    
  end

  def list_books
    puts "New Book Releases"
    puts <<-DOC.gsub /^\s*/, ''
      1. The Great Alone  by Kristin Hannah  Available: February 6 2018
      2. Girl, Wash Your Face  by Rachel Hollis  Available: February 6 2018
      3. Look for Me  by Lisa Gardner  Available: February 6 2018
    DOC
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
        puts "Thank you for using the New Book Releases application"
      else
        puts "Incorrect enty, type list or exit"
      end
    end
  end

end
