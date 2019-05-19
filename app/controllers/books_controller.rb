class BooksController < ApplicationController

	def index
		@book = Book.new
		@books = Book.all
	end
	def create
		book = Book.new(book_params)
		book.user_id = current_user.id
		book.save
		puts book.errors.full_messages
		redirect_to user_path(current_user.id)
	end

	def show
  		@book = Book.new
		@books = Book.find(params[:id])
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		book = Book.find(params[:id])
		book.update(book_params)
		redirect_to user_path(current_user)
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to user_path(current_user)
	end

	private

	def book_params
		params.require(:book).permit(:title, :body)
	end

end
