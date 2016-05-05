module SwapHelper
  def find_book(book_id)
    book = Book.find_by(id: book_id)
    return book
  end

  def find_userphoto(user_id)
    userphoto = Userphoto.find_by(userid: user_id)
    if userphoto
      return userphoto
    else
      return false
    end
  end
end
