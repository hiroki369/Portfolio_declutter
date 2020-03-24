class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy, :confirm, :follow, :follower]
	before_action :check_user, only:[:edit]
	PER = 10

	def index
		@users = User.all.order(best_answer_count:"DESC").page(params[:page]).per(PER)
	end

	def show
	end

	def edit
	end

	def update
		if @user.update(user_params)
		    redirect_to user_path(@user),notice: "ユーザー情報が更新されました！"
		else render :edit
	    end
	end

	def destroy
		@user.destroy
		redirect_to root_path,notice: "正常に退会できました。"
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
    def check_user
    	unless params[:id].to_i == current_user.id
    		redirect_to user_path(current_user)
    	end
    end


end
