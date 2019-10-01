class BooksController < ApplicationController
	before_action :authenticate_user!

	def index
		@book = Book.new

		#search_modelの値によって、Bookを検索するかUserを検索するかが変化
		#search_wayの値によって、部分一致検索、前方一致検索、後方一致検索、完全一致検索が変化
		#self.searchはbook.rbに記入

		if params[:search] && params[:search_model] == "1"
			@books = Book.search(params[:search], params[:search_way])

		elsif params[:search] && params[:search_model] == "2"
			@users = User.search(params[:search], params[:search_way])
			render template: "users/index"

		else
			@books = Book.all
		end


		#検索履歴を保存
		if params[:search] && params[:order] == nil
			@history = current_user.search_histories.new
			@history.history = params[:search]
			@history.save!
		end

		#検索結果を非同期でソート
		if params[:order] && params[:order] == "1"
			@books_sort = @books.order("id")
			render :sort
		elsif params[:order] && params[:order] == "2"
			@books_sort = @books.order("title")
			render :sort
		end
	end

	def create
		@books = Book.all
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id)
		else
			render :new
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
