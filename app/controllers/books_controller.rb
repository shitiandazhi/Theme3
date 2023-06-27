class BooksController < ApplicationController
   before_action :is_matching_login_book, only: [:edit, :update]
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice]= "You have created book successfully."
    redirect_to book_path(@book.id)
    else
    @user = current_user
    @books = Book.all
    render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user

  end

  def show
     @book = Book.find(params[:id])
     @users= User.all
     @newbook = Book.new
     @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice]= "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def is_matching_login_book
  @book = Book.find(params[:id])
  unless @book.user == current_user
    redirect_to books_path
  end
  end
end


