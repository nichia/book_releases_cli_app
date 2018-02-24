class BookReleasesCliApp::CLI

  def call
    load_new_releases
    list_store_menu
  end #-- call --

  def load_new_releases
    puts "Loading new releases from Barnes and Noble website..."
    bn = BookReleasesCliApp::Store.new("Barnes and Noble (B&N)", BookReleasesCliApp::Scraper.bn_scraper)

    puts "Loading new releases from Books a Million website..."
    bam = BookReleasesCliApp::Store.new("Books a Million (BAM!)", BookReleasesCliApp::Scraper.bam_scraper)
    #binding.pry
  end #-- load_new_releases

  def list_store_menu
    system "clear" or system "cls"

    input = nil
    while input.to_i != 9
      puts "New Book Releases"
      puts "=================".colorize(:blue)

      BookReleasesCliApp::Store.print_all

      puts "[9]. Exit"
      puts "Enter your choice: "

      input = gets.strip.downcase

      if input.to_i == "9"
        puts "Thank you for using New Book Releases"
      elsif input.to_i.between?(1, BookReleasesCliApp::Store.all.count)
        selected_store = BookReleasesCliApp::Store.find(input.to_i)
        list_books_by_store(selected_store)
        view_book(selected_store)
      else
        puts "Incorrect entry. Enter the store number or type '9' to exit.".colorize(:red)
      end
    end
  end #-- list_store_menu --

  def list_books_by_store(selected_store)
    system "clear" or system "cls"

    puts "\n#{selected_store.name} New Releases\n".colorize(:blue)

    BookReleasesCliApp::Store.print_books_by_store(selected_store)
    #selected_store.books.each.with_index(1) do |book, i|
    #  puts "#{i}. #{book.title} - #{book.author} - #{book.release_date} - #{book.type} #{book.price}"
    #end

    puts ""
  end #-- list_books_by_store --

  def view_book(selected_store)
    input = nil
    while input != "exit"
      puts "Enter a book number to show more information about the book."
      puts "Type 'list' to see the #{selected_store.name} list again or type 'exit' to select a different store."

      input = gets.strip.downcase

      if input.to_i.between?(1, selected_store.books.count)
        book = selected_store.find_book(input.to_i)
        puts ""
        puts "Title: #{book.detail_title}"
        puts "Author: #{book.detail_author}"
        puts "Release Date: #{book.release_date}  ||  Format: #{book.type}  ||  Price: #{book.price}"
        puts "OVERVIEW: #{book.overview}"
        puts ""
      elsif input == "list"
        list_books_by_store(selected_store)
      elsif input == "exit"
        puts ""
      else
        puts "Invalid entry.".colorize(:red)
      end
    end
  end #-- view_book --

end #-- BookReleasesCliApp::CLI --
