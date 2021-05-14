class Api::V1::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @users = User.all
    render json: @users
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { status: 'Success', message: 'User deleted' }
    else
      render json: { status: 'Fail', message: 'Error while deleting user' }
    end
  end
end
