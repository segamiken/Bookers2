class BooksController < ApplicationController
	before_action :authenticate_user!

	def index
		@book = Book.new
		@books = if params[:search]
			Book.where('title LIKE?',"%#{params[:search]}%")
			else
			Book.all
		end
	end

	def create
		@books = Book.all
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "Book was successfully added"
			redirect_to book_path(@book.id)
		else
			render :index
		end
	end

	def show
  		@book = Book.new
		@books = Book.find(params[:id])
		@post_comment = PostComment.new
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user != current_user
     	   redirect_to books_path
    	end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "Book was successfully updated"
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
		params.require(:book).permit(:title, :body)
	end

end
