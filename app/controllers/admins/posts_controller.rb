class Admins::PostsController < ApplicationController
	before_action :authenticate_admin!
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def show
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to admins_posts_path, notice: "投稿が更新されました！"
		else
		@posts = Post.all
	    render :index, notice:"投稿の更新に失敗しました！！"
		end
	end

	def destroy
		@post.destroy
		redirect_to admins_posts_path
	end


	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :body, :post_image)
	end
end
