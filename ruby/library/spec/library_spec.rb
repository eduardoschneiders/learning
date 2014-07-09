require 'spec_helper'

describe Library do
  before :all do
    lib_obj = [
      Book.new('Book title 1', 'Author 1', :category_1),
      Book.new('Book title 2', 'Author 2', :category_2),
      Book.new('Book title 3', 'Author 3', :category_3),
      Book.new('Book title 4', 'Author 4', :development),
      Book.new('Book title 5', 'Author 5', :development)
    ]

    File.open "books.yml", "w" do |f|
      f.write YAML::dump lib_obj
    end
  end

  before :each do
    @lib = Library.new 'books.yml'
  end

  describe '#new' do
    context 'with no parameters' do
      it 'has no books' do
        lib = Library.new
        expect(lib).to have(0).books
      end
    end

    context 'with a yaml file parameter' do
      it 'has five books' do
        expect(@lib).to have(5).books
      end
    end
  end

  it 'returns all teh books in a given category' do
    expect(@lib.get_books_in_category(:development).length).to eql 2
  end

  it 'accepts new books' do
    @lib.add_book(Book.new('Book title added', 'Author added', :category))
    expect(@lib.get_book('Book title added')).to be_an_instance_of Book
  end

  it 'saves the library' do
    @lib.add_book(Book.new('test', 'author', :category))
    books = @lib.books.map { |book| book.title }
    @lib.save
    lib2 = Library.new 'books.yml'
    books2 = lib2.books.map { |book| book.title }

    expect(books).to eql books2
  end
end
