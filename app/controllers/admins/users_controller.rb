class Admins::UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :restore_confirmation]
	before_action :authenticate_admin!

	def top
	end

	def index
		@users = User.all.with_deleted
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

	def restore_confirmation
	end

	def restore
		@user.restore(user_params)
		redirect_to admins_users_show_path(@user)
	end


	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end


	def set_user
    	@user = User.with_deleted.find(params[:id])
    end
end
