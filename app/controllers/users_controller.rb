class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin?, only: [:index, :show, :manage_exercises]
  before_action :set_user, only: [:show, :manage_exercises]

  def index
    @users= User.trainee
  end

  def show
    unless @user
      render partial: 'shared/error'
    end
    @all_exercises= Exercise.all
  end

  def manage_exercises
    user= User.find_by(id: params[:id])
    # Change exercise for user in database
    if user.update(exercise_ids: params[:user][:exercise_ids])
      # Send mail to user when exercises are updated
      UserMailer.with(exercises: params[:user][:exercise_ids], email: user.email).user_exercise_update.deliver_later
      redirect_to user_path(params[:id]), notice: "Exercises changed successfully!"
    else
      redirect_to user_path(params[:id]), notice: "No new exercises added."
    end
  end

  def start_set
    @current_user_exercises= current_user.current_day_exercises
  end

  private
  def user_params
    params.require(:user).permit(:exercise_ids)
  end

  def set_user
    @user= User.find_by(id: params[:id])
  end
end
