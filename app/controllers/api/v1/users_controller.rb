class Api::V1::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @users = User.all
    render json: @users, include: [:todos]
  end

  def destroy
    begin
	    @user = User.find(params[:id])
	    if @user.destroy
	      render json: { status: 'Success', message: 'User deleted' }
	    else
	      render json: { status: 'Fail', message: 'Error while deleting user' }
	    end
    rescue ActiveRecord::RecordNotFound 
      render json: { error: "Record not found for user" }, status: :not_found
    end
  end
end
