class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :only_admin, only: [:index, :show, :manage_exercises]
  before_action :set_user, only: [:show, :manage_exercises]

  def index
    @users= User.trainee
  end

  def show
    @Exercises= Exercise.all
  end

  def manage_exercises
    user= User.find_by(id: params[:id])
    old_exercise_ids= user.exercise_ids.map(&:to_s)
    new_exercise_ids= params[:user][:exercise_ids]
    # Change exercise for user in database
    user.update(exercise_ids: new_exercise_ids)
    # Send mail only if exercises were either added or removed
    if new_exercise_ids.difference(old_exercise_ids).present? || new_exercise_ids.count < old_exercise_ids.count
      UserMailer.with(exercises: new_exercise_ids, email: user.email).user_exercise_update.deliver_now
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
    unless @user
      render partial: 'shared/error'
    end
  end
end
