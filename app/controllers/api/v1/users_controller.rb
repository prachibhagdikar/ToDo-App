class Api::V1::UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def index
		@users = User.includes(:todos).where.not(todos: {id: nil})
		render json: @users
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy && @user.todos.present?
			render json: {status: "Success", message: "User deleted"}
		else
			render json: {status: "Fail", message: "Error while deleting user"}
		end

	end
end
