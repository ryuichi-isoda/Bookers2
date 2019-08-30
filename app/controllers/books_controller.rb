class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit]
  def index
    # @userはログインしたアカウント
    @user = current_user
    # 本の空のモデルの生成
    @book = Book.new
    # 本を全件取得
    @books = Book.all
  end

  def show
    # showページのidを取得
    @book = Book.find(params[:id])
    # 本の空のモデルの生成
    @newbook = Book.new
    # @userは@bookに紐付くアカウント
    @user = @book.user
  end

  def new
  end

  def create
    # 本の空のモデルの生成
    @book = Book.new(book_params)
    # @userはログインしたアカウント
    @user = current_user
    # 本のidはログインしたユーザーに結びつける
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      # 本を全件取得
      @books = Book.all
      render template: "users/show"
    end
  end


  def edit
    @user = current_user
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "Book was successfully destroyed."
     redirect_to books_path
    else
     render template: "users/show"
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id then
      redirect_to books_path
    end
  end
end
