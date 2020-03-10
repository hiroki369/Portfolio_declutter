class Admins::SearchesController < ApplicationController

	def index
		@target = params[:target]
	  if @target == "post"
		@posts = Post.search(params[:search])
	  elsif
		@users = User.search(params[:search])
		render 'admins/users/index.html.erb'
	  end
	end
end

