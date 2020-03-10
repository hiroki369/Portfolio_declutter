class Admins::UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]
	before_action :authenticate_admin!

	def top
	end

	def index
		@users = User.all
	end

	def show
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to admins_users_show_path(@user)
		else
			render :edit
		end
	end

	def close
	end

	def reopen
	end


	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end

	def set_user
    	@user = User.find(params[:id])
    end
end
