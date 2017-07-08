class CommentsController < ApplicationController
	before_action :find_post
	before_action :find_comment, only: [:edit,:destroy] 
	before_action :create_comment, only: [:create,:update] 
	def create
		@comment.user_id = current_user.id if current_user

		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end
	def edit
	end

	def update
		if @comment.update(params[:comment].permit(:comment))
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end

		def destroy
			@comment.destroy
			redirect_to post_path(@post)
	end

	private 

	def find_post
		@post = Post.find(params[:post_id])
	end

	def create_comment
		@comment = @post.comments.create(params[:comment].permit(:comment))
	end

	def find_comment
		@comment = @post.comments.find(params[:id])
	end
end
