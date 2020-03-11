class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy, :confirm, :follow, :follower]



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
		@user.destroy
		redirect_to root_path
	end

	def follow
	end

	def follower
	end

	def confirm
	end


private

	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
    def set_user
    	@user = User.find(params[:id])
    end


end
