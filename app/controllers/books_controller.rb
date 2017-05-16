require 'pry'

class BooksController < BlocWorks::Controller
  def welcome
    render :welcome, book: "Eloquent Ruby"
  end

  def index
     render :index, books: Book.all
   end

   def show
     binding.pry
     book = Book.find(params['id'])
     render :show, book: book
   end
end
