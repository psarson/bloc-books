require_relative '../models/library'
require_relative '../models/library_mapper'
require 'rack'

class BooksController < BlocWorks::Controller
  attr_reader :request

  def initialize(env)
    @request ||= Rack::Request.new(env)
  end

  def welcome
    render :welcome, book: "Eloquent Ruby"
  end

  def new
    render :new
  end

  def create
    @lib = Library.new

    title = @request.params.values[0].values[0]
    author = @request.params.values[0].values[1]
    book_id = @request.GET.values[0].to_i

    @book = Book.new(title, author, book_id)

    @lib.add_book(@book)

    render :create
  end

  def show
    library_id = @request.GET.values[0].to_i
    map = LibraryMapper.new
    library = map.find_one(library_id)
    books = library.find(library_id)
    @books = books
    render :show, books: @books
  end

  def edit
    params = @request.params.values.join.split(",")

    library_id = params[1].to_i
    book_id = params[0].to_i

    map = LibraryMapper.new

    library = map.find_one(library_id)
    @book = library.find_one(book_id, library_id)
    puts "#{@book}"
    render :edit, book: @book
  end

  def update
    @params = @request.params.values

    ids = @params[0]

    #ids is actually a string "book_id, library_id"
    library_id = ids[2].to_i
    book_id =  ids[0].to_i

    title = @params[1].values[0]
    author = @params[1].values[1]

    map = LibraryMapper.new
    library = map.find_one(library_id)

    library.update(book_id, library_id, title, author)

    @return_id = @request.params.values[0]
    render :update, id: @return_id[2]
  end

  def delete
    @params = @request.params.values

    ids = @params[0]

    #ids is actually a string "book_id, library_id"
    library_id = ids[2].to_i
    book_id =  ids[0].to_i

    map = LibraryMapper.new
    library = map.find_one(library_id)

    library.delete(book_id, library_id)

    render :delete
  end

end
