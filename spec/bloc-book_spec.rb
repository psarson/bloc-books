#BDD - Behavior Driven Development
#BDD style integration test - req. active webserver

require_relative '../config/application'

require "rack/test"
require 'test/unit'

class BlocBooksTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    BlocBooks::Application.new
  end

  def test_welcome_status
    get '/books/welcome'
    puts last_response.body != nil
    assert last_response.ok?
    assert_equal 200, last_response.status
  end

  def test_welcome_body
    get '/books/welcome'
    assert last_response.ok?
    puts last_response.body != nil
  end

  def test_new
    get '/books/new'
    assert last_response.ok?
    assert_equal 200, last_response.status
  end

  def test_create
    get '/books/create'
    assert last_response.ok?
    assert_equal 200, last_response.status
  end

  def test_update
    get '/books/update'
    assert last_response.ok?
    assert_equal 200, last_response.status
  end

  def test_edit
    get '/books/edit'
    puts last_response.body != nil
    assert last_response.ok?
    assert_equal 200, last_response.status
  end


  def test_destroy
    get '/books/destroy'
    assert last_response.ok?
    assert_equal 200, last_response.status
  end
end
