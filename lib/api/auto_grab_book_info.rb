require_relative 'google_books_api/google_books_api'
require 'json'

class SaveBookInfo
  def initialize()
    @google_book = GoogleBooksAPI.new
  end

  def save_book_info(keyword, result_num, save_path, subject)
    full_save_path = save_path + keyword + '_books.json'
    if !File.file?(full_save_path)
      @google_book.search(keyword, result_num, subject)
      @google_book.to_hash(@google_book.books)
      actual_book_length = @google_book.books_hash_list.length
    else
      puts "Error: file: " + "\n" + full_save_path  + "\n" \
      + "already exisit, please remove the current one before save."
      puts ''
      return false
    end

    if actual_book_length > (result_num - 10)
      @google_book.to_json(@google_book.books_hash_list, full_save_path)
      puts 'Book info for key word: ' + keyword.upcase + ' saved successfully!'
      puts 'Find your saved file here: ' + "\n" + full_save_path
      puts ''
    else
      puts 'Error: Search result for keyword: ' + keyword.upcase + \
           ' is incomplete due to Google server\'s http request limitation' \
           + ' per minute please try this later.'
      puts 'Request book num: ' + result_num.to_s
      puts 'Actual result num: ' + actual_book_length.to_s
      puts ''
    end

  end

end

# puts File.dirname(File.dirname(__FILE__))
book_info = SaveBookInfo.new
save_path = File.dirname(File.dirname(__FILE__)) + '/save_book_info/'
# book_info.save_book_info('ruby', 270, save_path, 'computers') Success!
# book_info.save_book_info('java', 650, save_path, 'computers') Success!
# book_info.save_book_info('php', 300, save_path, 'computers') Success!






# test1 = File.open('test.txt',"w")
# test1.write('1')
# test1.close
# test2 = File.open('test.txt',"w")
# test2.write('2')
# test2.close
