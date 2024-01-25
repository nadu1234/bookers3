class BooksController < ApplicationController

  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @books = Book.all.page(params[:page]).per(8)
    # @book_id = Book.find(params[:id])
    # @book_favorite = Book.find(@book_id.id)
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user_id = User.find(@book.user_id)
    @user = User.find(current_user.id)
    # @user_id = User.find(@book.user_id) ここに記述するとエラーがでた。保存できてなかっただけ？
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
