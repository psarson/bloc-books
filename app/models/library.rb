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

    if object.library_id != self.id
      object.library_id = self.id
    end

    object.instance_variables.each_with_index do |variable, index|
      @data_array << object.instance_variable_get(variable)
    end
  end

  def find
    @book_array = []
    @data_file.readlines.each do |line|
      new_line = line.split(",")
      book = Book.new(new_line[0], new_line[1], new_line[2], new_line[3])
      @book_array << book
    end
    @book_array
  end

  def find_one(id)
    find.each do |object|
      if object.book_id == id
        @book = object
      end
    end
    @book
  end

  def update(id, title, author)
    @string_array = []

    @data_file.readlines.each_with_index do |line, index|
      @string_array << Array.new(line.split /,\s*/)
    end

    update_entry = @string_array[id]

    if title
      update_entry[0] = title
    end
    if author
      update_entry[1] = author
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

  def delete(id)
    @string_array = []

    @data_file.readlines.each_with_index do |line, index|
      @string_array << Array.new(line.split /,\s*/)
    end

    @string_array.slice!(id-1)

    @string_array.each_with_index do |line, index|
      line[2] = index + 1
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
