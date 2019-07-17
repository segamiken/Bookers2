class PostCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@comment = current_user.post_comments.new(post_comment_params)
		@comment.book_id = @book.id
		@comment.user_id = current_user.id
		if @comment.save
		   redirect_to book_path(@book.id)
		else
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:book_id])
		comment = current_user.post_comments.find_by(book_id: book.id, id: params[:id])
		comment.destroy
		redirect_to book_path(book.id)
	end

	def edit
		@book = Book.find(params[:book_id])
		@comment = current_user.post_comments.find_by(book_id: @book.id, id: params[:id])
	end

	def update
		@book = Book.find(params[:book_id])
		@comment = current_user.post_comments.find_by(book_id: @book.id, id: params[:id])
		if @comment.update(post_comment_params)
		   redirect_to book_path(@book.id)
		else
		   render :edit
	    end
	end

	private
	def post_comment_params
		params.require(:post_comment).permit(:user_id, :book_id, :comment)
	end
end
