class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books
  end

  def index
  	@book = Book.new
  	@users = User.all
  end

  def edit
  	@user = User.find(params[:id])
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

  private

	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
       redirect_to root_path
    end
  end

end

