class PostCommentsController < ApplicationController
	def create
		@post =Post.find(params[:post_id])
		@comment = current_user.post_comments.new(post_comment_params)
		@comment.post_id = @post.id
		@comment.save
	end

	def destroy
		@post =Post.find(params[:post_id])
		@comment = PostComment.find(params[:id])
		@comment.destroy
	end

	def authorize_best_answer
		@post =Post.find(params[:post_id])
		user =@post.user_id
		@comment = PostComment.find(params[:post_comment_id])
		@comment.best_answer = true
		@post.user.best_answer_count += 1
		if@comment.save
			@post.user.save
			redirect_to post_path(@post)
		else
		  render templete: "posts/show"
		end
	end

    private

    def post_comment_params
    	params.require(:post_comment).permit(:user_id,:post_id,:body,:dispose,:best_answer)
    end



end
