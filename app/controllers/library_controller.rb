require_relative '../models/library_mapper'
require 'rack'

class LibraryController < BlocWorks::Controller
  attr_reader :request

  def initialize(env)
    @request ||= Rack::Request.new(env)
  end

  def new
    render :new
  end

  def create
    render :create
  end

  def show
    map = LibraryMapper.new
    @library = map.find_all
    render :show, library: @library
  end

  def edit
    @map = LibraryMapper.new
    id = @request.params.values[0]
    puts id
    puts @map.find_one(id)
    render :edit
  end


end
