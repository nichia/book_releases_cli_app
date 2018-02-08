class BookReleasesCliApp::CLI

  def call
    list_books
    menu
  end

  def list_books
    puts "New Book Releases"

    @newbooks = BookReleasesCliApp::NewBooks.all
    @newbooks.each.with_index(1) do |newbook, i|
      puts "#{i}. #{newbook.title} - #{newbook.author} - #{newbook.release_date}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the book number for more information or type list to see the books again or type exit"
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i <= (@newbooks.count - 1)
        newbook = @newbooks[input.to_i - 1]
        puts "Title: #{newbook.title}  Author: #{newbook.author}  Release Date: #{newbook.release_date}  Format: #{type}  Price: #{price}"
        puts "OVERVIEW: #{overview}"
      elsif input == "list"
        list_books
      elsif input == "exit"
        puts "Thank you for using New Book Releases"
      else
        puts "Incorrect enty, type list or exit"
      end
    end
  end

end
