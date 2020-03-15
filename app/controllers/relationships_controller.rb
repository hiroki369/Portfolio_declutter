class RelationshipsController < ApplicationController
	before_action :set_user

	def create
		user = User.find(params[:follow_id])
		if current_user.follow(user)
			user.create_notification_follow(current_user)
			 redirect_to user_path(user)
		else
			redirect_to user_path(user)
		end
	end

	def destroy
		user = User.find(params[:follow_id])
		if current_user.unfollow(user)
			redirect_to user_path(user)
		else
			redirect_to user_path(user)
		end
	end




private
    def set_user
    user = User.find(params[:follow_id])
    end
end
