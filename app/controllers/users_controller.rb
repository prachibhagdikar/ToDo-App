class UsersController < ApplicationController

	before_action :authenticate_user!

	def show
		@user = current_user
	end

	def edit
		
	end

	def update
		user = User.find(params[:user][:id])
		if user.update(user_params)
			redirect_to profile_path
		else
			render :edit
		end
	end

	private

	def user_params
		params.require(:user).permit(:id,:first_name,:last_name,:email,:password,:password_confirmation,:gender,:address,:profile_image)
	end
end
