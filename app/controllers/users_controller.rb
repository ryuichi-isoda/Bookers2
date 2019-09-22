class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:show, :index, :edit]
  def index
    # @userはログインしたアカウント
    @user = current_user
    # ユーザーを全件取得
    @users = User.all
    # 本の空のモデルの生成
    @book = Book.new
  end

  def show
    # 本の空のモデルの生成
    @book = Book.new
    # @userはbookを投稿したユーザー
    @user = User.find(params[:id])
    # @booksは投稿したuserに結びついたbook全て
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      # redirect_to user_url(current_user) と同じ意味
      redirect_to current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      # redirect_to user_url(current_user)と同じ意味
      redirect_to current_user
    else
      # render action: :edit と同じ意味
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
