class BookReleasesCliApp::CLI

  def call
    load_new_releases
    list_books
    menu
  end

  def load_new_releases
    #puts "Loading new releases from the Books a Million website..."
    #@newbooks = BookReleasesCliApp::NewBooks.bam_scraper

    puts "Loading new releases from the Barnes and Noble website..."
    @newbooks = BookReleasesCliApp::NewBooks.bn_scraper

  end

  def list_books
    puts "New Book Releases"

    @newbooks.each.with_index(1) do |newbook, i|
      puts "#{i}. #{newbook.title} - #{newbook.author} - #{newbook.release_date}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the book number for more information or type list to see the books again or type exit"
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i <= @newbooks.count
        newbook = @newbooks[input.to_i - 1]
        puts "Title: #{newbook.detail_title}  Author: #{newbook.detail_author}  "
        puts "Release Date: #{newbook.release_date} Format: #{newbook.type}  Price: #{newbook.price}"
        puts "OVERVIEW: #{newbook.overview}"
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
