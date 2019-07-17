class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books

    @follows = @user.followings
    @followers = @user.followers
  end

  def index
  	@book = Book.new
  	@users = User.all
  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "User information was successfully updated"
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  def follows
    @user = User.find(params[:id])
    @following = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end


end

