class SearchesController < ApplicationController
	PER = 10

	def index
		@target = params[:target]
		@target == "post"
		@posts = Post.search(params[:search]).page(params[:page]).per(PER)
		@posts_count = @posts.count"#{aaaaaaa}"
		#サーチワードはprams:searchに格納されてると思う。
		render :'posts/index'
	end
end

