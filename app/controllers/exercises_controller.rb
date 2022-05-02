class ExercisesController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @exercises= current_user.exercises
  # end

  def show
    @exercise= Exercise.find(params[:id])
  end

  def change_favourite
    type= params[:type]
    # binding.pry
    user_exercise = current_user.user_exercises.find_by(exercise_id: params[:id])
    user_exercise.update(favourite: type == 'Favourite')
    redirect_to :homepage
  end
end
