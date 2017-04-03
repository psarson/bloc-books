require 'bloc_works' #does this need to here?

class Book
  attr_accessor :title, :author, :book_id

  def initialize(title, author, book_id=0, id=0)
    @title = title
    @author = author
    @book_id = book_id.to_i
    @id = id.to_i
   end
end
