class BookReleasesCliApp::CLI

  def call
    load_new_releases
    list_menu
  end #-- call --

  def load_new_releases
    puts "Loading new releases from Books a Million website..."
    bam = BookReleasesCliApp::Store.new("Books a Million (BAM!)", BookReleasesCliApp::Scraper.bam_scraper)

    puts "Loading new releases from Barnes and Noble website..."
    bn = BookReleasesCliApp::Store.new("Barnes and Noble (B&N)", BookReleasesCliApp::Scraper.bn_scraper)
  end #-- load_new_releases

  def list_menu
    system "clear" or system "cls"

    input = nil
    while input.to_i != 9
      puts "New Book Releases"
      puts "=================".colorize(:blue)

      BookReleasesCliApp::Store.print_all

      puts "[9]. Exit"
      puts "Enter your choice: "

      input = gets.strip.downcase
      binding.pry

      if input.to_i == "0"
        puts "Thank you for using New Book Releases"
      elsif input.to_i.between?(1, BookReleasesCliApp::Store.all.count)
        list_books(input.to_i)
        view_books(input.to_i)
      else
        puts "Incorrect entry. Enter the store number or type '9' to exit.".colorize(:red)
      end
    end
  end #-- list_menu --

  def list_books(store_index)
    selected_store = BookReleasesCliApp::Store.find(store_index)

    system "clear" or system "cls"
    puts "\n#{selected_store.name} New Releases\n".colorize(:blue)

    BookReleasesCliApp::Book.print_all

    #selected_store.books.each.with_index(1) do |book, i|
    #  puts "#{i}. #{book.title} - #{book.author} - #{book.release_date}"
      #puts "#{i}. #{book.title} - #{book.author} - #{book.release_date} - #{book.type} #{book.price}"
    #end

    puts ""
  end #-- list_menu --

  def view_books(store_index)
    selected_store = BookReleasesCliApp::Store.find(store_index)

    input = nil
    while input != "exit"
      puts "Enter a book number to show more information about the book."
      puts "Type 'list' to see the #{selected_store.name} list again or type 'exit' to select a different store."

      input = gets.strip.downcase
      binding.pry

      if input.to_i.between?(1, selected_store.books.count)
        book = selected_store.find_book(input.to_i)
        puts ""
        puts "Title: #{book.detail_title}"
        puts "Author: #{book.detail_author}"
        puts "Release Date: #{book.release_date}  ||  Format: #{book.type}  ||  Price: #{book.price}"
        puts "OVERVIEW: #{book.overview}"
        puts ""
      elsif input == "list"
        list_books(store_index)
      elsif input == "exit"
        puts ""
      else
        puts "Invalid entry.".colorize(:red)
      end
    end
  end #-- view_books --

end #-- BookReleasesCliApp::CLI --
