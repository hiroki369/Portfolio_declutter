class SearchesController < ApplicationController
	PER = 10

	def index
		@target = params[:target]
		@target == "post"
		@posts = Post.search(params[:search]).page(params[:page]).per(PER)
		@posts_count = @posts.count.to_s + "件のPostがヒットしました！"
	    if params[:search] == ""
		    @result = "Post全件を表示します。"
	    else
		@result = params[:search] + "の検索結果です。"
	    end
		render :'posts/index'
	end
end

