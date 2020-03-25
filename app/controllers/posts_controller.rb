class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only: [:show, :edit, :update, :destroy,]
	PER =10

	def new
		@post = Post.new
	end

	def index
		@posts = Post.all.order(created_at: :desc).page(params[:page]).per(PER)
	end

	def show
		@post_comment = PostComment.new
		@best_answer = @post.post_comments.find_by(best_answer: "true")
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to posts_path, notice: "投稿されました！"
		else
		  render :new
		end
	end

	def edit
		check_user(@post)
	end


	def update
		if @post.update(post_params)
			redirect_to post_path(@post.id), notice: "Postが更新されました！"
		else render :edit
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path, notice: "Postを削除しました！"
	end

	def best_answer
		@post =Post.find(params[:post_id])
		@comment = PostComment.find(params[:post_comment_id])
	end


private

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :body, :post_image)
	end

	def check_user(post)
		if post.user.id != current_user.id
			redirect_to posts_path
		end
	end

end
