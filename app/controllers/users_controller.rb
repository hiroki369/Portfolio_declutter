class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :follow, :follower]
	before_action :authenticate_user!

	def index
		@users = User.all.order(best_answer_count:"DESC")
	end

	def show
	end

	def edit
	end

	def update
		if @user.update(user_params)
		    redirect_to user_path(@user)
		else render :edit
	    end
	end

	def destroy
	end

	def follow
	end

	def follower
	end



private

	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
    def set_user
    	@user = User.find(params[:id])
    end


end
