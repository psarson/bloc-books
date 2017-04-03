require_relative 'library'
require 'bloc_works'

class LibraryMapper
  attr_accessor :library_array, :library

  def initialize
    @file = File.open("library_database.txt")
  end


  def find_all
    @library_array = []
    @file.readlines.each do |line|
      new_line = line.split(",")
      library = Library.new(new_line[0], new_line[1])
      @library_array << library
    end
    @library_array
  end

  def find_one(id)
    find_all.each do |object|
      if object.id == id
        @library = object
      end
    end
    @library
  end


end
