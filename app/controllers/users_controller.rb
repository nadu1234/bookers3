class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
  end
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).per(8)
    @book = Book.new
    @user = User.find(params[:id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @books = Book.all
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end


  # フォロー一覧
def follows
  user = User.find(params[:id])
  @users = user.following_user
end

# フォロワー一覧
def followers
  user = User.find(params[:id])
  @user = user.follower_user
end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
