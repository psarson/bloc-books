require 'bloc_works' #does this need to be here?
require_relative 'book'


class Library
  attr_accessor :data_file, :book_array, :book, :id, :name

  def initialize(id=0, name)
    @id = id.to_i
    @name = name
    @data_file = File.open("database.txt")
  end

  def add_book(object)
    if object.is_a? Book
      serialize(object)
    else
      puts "Error #{object} is not recognized"
    end
    save
  end

  def serialize(object)
    @data_array = []
    if object.book_id == 0
      object.book_id = last_index + 1
    end

    if object.id != self.id
      object.id = self.id
    end

    object.instance_variables.each_with_index do |variable, index|
      @data_array << object.instance_variable_get(variable)
    end
  end

  def find(library_id)
    @book_array = []
    @data_file.readlines.each do |line|
      new_line = line.split(",")
      if new_line[3].to_i == library_id.to_i
        book = Book.new(new_line[0], new_line[1], new_line[2], new_line[3])
        @book_array << book
      end
    end
    @book_array
  end

  def find_one(book_id, id)
    @books = find(id)
     @books.each do |object|
      if object.book_id == book_id
        @book = object
      end
    end
    @book
  end

  def update(id, library_id, title, author)
    @string_array = []
    @data_file.readlines.each do |line, index|
      @string_array << Array.new(line.split /,\s*/)
    end

    @string_array.each do |element|
      if element[-2].to_i == id && element[-1].to_i == library_id
        puts "Found It!"
        puts "#{element[0] = title}"
        puts "#{element[1] = author}"
      end
    end

    @string_array.map! do |line|
      line*","
    end

    File.open("database.txt", "w") do |f|
      @string_array.each do |line|
        f.puts line
      end
    end
  end

  def delete(id, library_id)
    @string_array = []

    @data_file.readlines.each_with_index do |line, index|
      @string_array << Array.new(line.split /,\s*/)
    end

    @string_array.each do |element|
      if element[-2].to_i == id && element[-1].to_i == library_id
         @string_array
      end
    end

    @string_array.map! do |line|
      line*","
    end

    File.open("database.txt", "w") do |f|
      @string_array.each do |line|
        f.puts line
      end
    end
  end

  def save
    text = @data_array.join(",")
    File.open("database.txt", "a") do |line|
      line.puts text
    end
  end

  def last_index
    @data_file.readlines.length
  end
end
