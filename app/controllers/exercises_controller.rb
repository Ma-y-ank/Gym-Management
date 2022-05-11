require 'csv'
class ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin?, only: [:new, :edit, :destroy, :import]

  def index
    # binding.pry
    if params[:exercise].present?
      @exercises= current_user.exercises.by_category(params[:exercise][:category])
    else
      @exercises= current_user.exercises
    end
  end

  def show
    @exercise= Exercise.find(params[:id])
  end

  def change_favourite
    type= params[:type]
    # binding.pry
    user_exercise = current_user.user_exercises.find_by(exercise_id: params[:id])
    user_exercise.update(favourite: type == 'Favourite')
    redirect_to :homepage, notice: "You have successfully changed the exercise to #{type}."
  end

  def new
      @exercise= Exercise.new
  end

  def create
    @exercise= Exercise.new(exercise_params)

    if @exercise.save
      # binding.pry
      redirect_to exercise_path(@exercise), notice: "Exercise added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
      @exercise= Exercise.find(params[:id])
  end

  def update
    @exercise= Exercise.find(params[:id])
    if @exercise.update(exercise_params)
      redirect_to root_path, notice: "Exercise updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise= Exercise.find_by(id: params[:id])
    @exercise.destroy
    redirect_to :homepage, notice: "Exercise deleted successfully"
  end

  def import
    Exercise.import(params[:file])
    redirect_to root_path, notice: "Import Successful"
  end

  private
    def exercise_params
      params.require(:exercise).permit(:name, :description, :category, :link)
    end
end
