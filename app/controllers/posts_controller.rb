class PostsController < ApplicationController
	before_action :set_posts, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	def new
		@post = Post.new
	end

	def index
		@posts = Post.all
	end

	def show
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save!
			redirect_to root_path, notice: "投稿されました！"
		else @post = Post.new
			render :new
		end
	end

	def edit
	end


	def update
		if @post.update(post_params)
			redirect_to post_path(@post.id), notuce: "投稿が更新されました！"
		else render :edit
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

private

	def set_posts
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :body, :post_image)
	end


end
