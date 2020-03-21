class Admins::SearchesController < ApplicationController
	PER = 30

	def index
		@target = params[:target]
	  if @target == "post"
		@posts = Post.search(params[:search]).page(params[:page]).per(PER)
		render 'admins/posts/index.html.erb'
	  elsif
		@users = User.search(params[:search]).page(params[:page]).per(PER)
		render 'admins/users/index.html.erb'
	  end
	end
end

