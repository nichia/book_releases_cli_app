class BookReleasesCliApp::CLI

  def call
    load_new_releases
    list_menu
  end #-- call --

  def load_new_releases
    puts "Loading new releases from Books a Million website..."
    bam = Store.new("Books a Million (BAM!)", BookReleasesCliApp::Scraper.bam_scraper)

    puts "Loading new releases from Barnes and Noble website..."
    bn = Store.new("Barnes and Noble (B&N)", BookReleasesCliApp::Scraper.bn_scraper)
  end #-- load_new_releases

  def list_menu
    input = nil
    while input != "exit"
      puts "New Book Releases"
      puts "================="

      BookReleasesCliApp::Store.print_all
      #puts "[1] Books a Million New Releases"
      #puts "[2] Barnes & Noble New Releases"

      puts "[exit] To Exit"
      puts "Enter your choice: "

      input = gets.strip.downcase

      if input == "exit"
        puts "Thank you for using New Book Releases"
      elsif input.to_i.between?(1, BookReleasesCliApp::Store.all.count)
        list_books(input.to_i)
        view_books(input.to_i)
      else
        puts "Incorrect enty, type list or exit"
      end

      #case input.to_i
      #when 1, 2
      #  if input.to_i == 1
      #    @newbooks = @newbooks_bam
      #    name = "Books a Million"
      #  else
      #    @newbooks = @newbooks_bn
      #    name = "Barnes & Noble"
      #  end
#
      #  list_books(name)
      #  view_menu(name)
      #when "x"
      #else
      #  puts "Incorrect enty, type list or exit"
      #end
    #end
  end #-- list_menu --

  def list_books(store_index)
    selected_store = BookReleasesCliApp::Store.find(store_index)

    puts " "
    puts "#{selected_store.name} New Releases"
    puts " "

    #BookReleasesCliApp::Book.print_books

    selected_store.books.each.with_index(1) do |book, i|
      puts "#{i}. #{book.title} - #{book.author} - #{book.release_date} - #{book.type} #{book.price}"
    end

    puts " "
  end #-- list_menu --

  def view_books(store_index)
    selected_store = BookReleasesCliApp::Store.find(store_index)

    input = nil
    while input != "exit"
      puts "Enter the number for the book you would like more information."
      puts "Type 'list' to see a list of #{selected_store.name} books again or type 'exit' to quit."

      input = gets.strip.downcase

      if input.to_i.between?(1, selected_store.books.count)
      #if input.to_i > 0 && input.to_i <= @newbooks.count
        #newbook = @newbooks[input.to_i - 1]
        book = selected_store.find_book(input.to_i)
        puts "Title: #{book.detail_title}"
        puts "Author: #{book.detail_author}"
        puts "Release Date: #{book.release_date}  ||  Format: #{book.type}  ||  Price: #{book.price}"
        puts "OVERVIEW: #{book.overview}"
        puts " "
      elsif input == "list"
        list_books(store_index)
      elsif input == "exit"
        puts " "
      else
        puts "Incorrect enty, type valid number, 'list' or 'exit'"
      end
    end
  end #-- view_books --

end #-- BookReleasesCliApp::CLI --
