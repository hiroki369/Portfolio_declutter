class SearchesController < ApplicationController

	def index
		@target = params[:target]
		@target == "post"
		@posts = Post.search(params[:search])
	end
end

