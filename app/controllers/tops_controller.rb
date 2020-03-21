class TopsController < ApplicationController

	def index
	end

	def about
	end

	def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com',name: 'Guest_user') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
