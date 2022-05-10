class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin?

  def index
    @users= User.user
  end

  def show
    @user= User.find_by(id: params[:id])
  end

  def manage_exercises
    User.find_by(id: params[:id]).update(exercise_ids: params[:user][:exercise_ids])
    redirect_to user_path(params[:id]), notice: "Exercises changed successfully!"
  end
end
