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
    # binding.pry
    new_exercises= Exercise.where(id: params[:user][:exercise_ids]).map(&:name)
    user= User.find_by(id: params[:id])
    # Change exercise for user in database
    user.update(exercise_ids: params[:user][:exercise_ids])
    # Send mail to user when exercises are updated
    UserMailer.with(exercises: new_exercises, email: user.email).user_exercise_update.deliver_later
    redirect_to user_path(params[:id]), notice: "Exercises changed successfully!"
  end
end
