class BooksController < BlocWorks::Controller
  def initialize(env)
    @request ||= Rack::Request.new(env)
  end

  def welcome
    render :welcome, book: "Eloquent Ruby"
  end

  def index
     render :index, books: Book.all
   end

   def show
    id = @request.env["QUERY_STRING"][1].to_i
    @book = Book.find(id)

    render :show, book: @book
   end

end
