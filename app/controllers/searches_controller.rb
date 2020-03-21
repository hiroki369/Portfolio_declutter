class SearchesController < ApplicationController
	PER = 10

	def index
		@target = params[:target]
		@target == "post"
		@posts = Post.search(params[:search]).page(params[:page]).per(PER)
		render :'posts/index'
	end
end

