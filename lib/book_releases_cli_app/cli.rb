class BookReleasesCliApp::CLI

  def call
    load_new_releases
    list_books_menu
  end #-- call --

  def load_new_releases
    puts "Loading new releases from Books a Million website..."
    @newbooks_bam = BookReleasesCliApp::NewBooks.bam_scraper

    puts "Loading new releases from Barnes and Noble website..."
    @newbooks_bn = BookReleasesCliApp::NewBooks.bn_scraper
  end #-- load_new_releases

  def list_books_menu
    input = nil
    while input.to_i != 3
      puts "New Book Releases"
      puts "================="
      puts "[1] Books a Million New Releases"
      puts "[2] Barnes & Noble New Releases"
      puts "[3] Exit"
      puts "Enter your choice: "
      input = gets.strip.downcase

      case input.to_i
      when 1, 2
        if input.to_i == 1
          @newbooks = @newbooks_bam
          name = "Books a Million"
        else
          @newbooks = @newbooks_bn
          name = "Barnes & Noble"
        end

        list_books(name)
        view_menu
      when 3, 'exit'
        puts "Thank you for using New Book Releases"
      else
        puts "Incorrect enty, type list or exit"
      end
    end
  end #-- list_books_menu

  def list_books(name)
    puts " "
    puts "#{name} New Releases"
    puts " "

    @newbooks.each.with_index(1) do |newbook, i|
      puts "#{i}. #{newbook.title} - #{newbook.author} - #{newbook.release_date} - #{newbook.type} - #{newbook.price}"
    end
  end #-- list_books --

  def view_menu
    input = nil
    while input != "exit"
      puts "Enter the book number for more information or type list to see the books again or type exit"
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i <= @newbooks.count
        newbook = @newbooks[input.to_i - 1]
        puts "Title: #{newbook.detail_title}"
        puts "Author: #{newbook.detail_author}"
        puts "Release Date: #{newbook.release_date}  ||  Format: #{newbook.type}  ||  Price: #{newbook.price}"
        puts "OVERVIEW: #{newbook.overview}"
        puts " "
      elsif input == "list"
        list_books
      elsif input == "exit"
        puts " "
      else
        puts "Incorrect enty, type list or exit"
      end
    end
  end #-- view_menu --

end #-- BookReleasesCliApp::CLI --
