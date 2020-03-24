class Admins::SearchesController < ApplicationController
	PER = 30

	def index
		@target = params[:target]
	  if @target == "post"
		@posts = Post.search(params[:search]).page(params[:page]).per(PER)
		@posts_count = @posts.count.to_s + "件のPostがヒットしました！"
		if params[:search] == ""
		     @result = "Post全件を表示します。"
	    else
		@result = params[:search] + "の検索結果です。"
	    end
		render 'admins/posts/index.html.erb'
	  elsif
		@users = User.search(params[:search]).page(params[:page]).per(PER)
		@users_deleted = User.all.only_deleted.search(params[:search]).page(params[:page]).per(PER)
		@users_valid = User.all.without_deleted.search(params[:search]).page(params[:page]).per(PER)
        if params[:search] == ""
        	@result = "User全件を表示します。"
	    else
	    	@result = params[:search] + "の検索結果です。"
	    end
		render 'admins/users/index.html.erb'
	  end
	end
end

