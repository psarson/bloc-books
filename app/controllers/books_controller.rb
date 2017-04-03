require_relative '../models/library'
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
    map = Library.new
    @books = map.find
    render :show, books: @books
  end

  def edit
    map = Library.new
    id = @request.GET.values[0].to_i
    puts id
    @book = map.find_one(id)
    render :edit, book: @book
  end

  def update
    map = Library.new

    id = @request.GET.values[0].to_i
    new_title = @request.params.values[1].values[0]
    new_author = @request.params.values[1].values[1]

    map.update(id, new_title, new_author)

    render :update
  end

  def delete
    map = Library.new

    id = @request.GET.values[0].to_i

    map.delete(id)

    render :delete
  end

end
