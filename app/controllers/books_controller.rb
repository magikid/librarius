class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    params.require(:book).permit!
    @book = Book.new(params[:book])
    if @book.save
      redirect_to book_path(@book)
    end
  end
end
