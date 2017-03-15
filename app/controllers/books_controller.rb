require 'bloc_works'

class BooksController < BlocWorks::Controller
  def welcome
    render :welcome, book: "Eloquent Ruby"
  end

  def new
    #directs to create#new page
  end

  def create
    #creates book object
  end

  def edit
    #directs to editing page
  end

  def update
    # access the book array
    # renders old value
    # take input
    # renders new value
  end

  def destroy
    # removes item from array
  end

end
