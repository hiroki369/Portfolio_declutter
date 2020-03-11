class Admins::RestoreConfirmationsController < ApplicationController

	def restore
		@user = User.with_deleted.find(params[:id])
		@user.restore
		redirect_to admins_users_show_path(@user)
	end
end
