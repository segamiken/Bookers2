class BooksController < ApplicationController
	before_action :authenticate_user!

	def index
		@book = Book.new

		if params[:search] && params[:search_model] == "1"
			@books = Book.search(params[:search], params[:search_way])
		elsif params[:search] && params[:search_model] == "2"
			@users = User.search(params[:search], params[:search_way])
			render template: "users/index"
		else
			@books = Book.all
		end

		if params[:search]
			@history = current_user.search_histories.new
			@history.history = params[:search]
			@history.save!
		end
	end

	def create
		@books = Book.all
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		respond_to do |format|
		if @book.save
			flash[:notice] = "Book was successfully added"
			format.json {render :json => @book}
			format.html {redirect_to book_path(@book.id)}
		else
			format.html {redirect_to books_path}
		end
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
