require 'csv'
class ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_admin, only: [:new, :edit, :destroy, :import, :create, :update]
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @exercises = (current_user.admin? ? Exercise.all : current_user.exercises)
    @filtering_params= params[:filtering_params].presence || filtering_params.to_unsafe_hash
    @filtering_params.each do |key, value|
      @exercises= @exercises.public_send("filter_by_#{key}", value) if value.present?
    end
    @pagy, @exercises = pagy(@exercises, items: 4)
  end

  def show
    @diet= @exercise.diets
  end

  def toggle_favourite
    @user_exercise = current_user.user_exercises.find_by(exercise_id: params[:id])
    @user_exercise.update(favourite: params[:type] == 'Favourite')
  end

  def change_status
    @user_exercises = current_user.current_day_exercises
    @current_user_exercise = current_user.user_exercises.find_by(exercise_id: params[:id])
    @current_user_exercise.update(completed: true)
  end

  def new
    @exercise= Exercise.new
  end

  def create
    @exercise= Exercise.new(exercise_params)

    if @exercise.save
      redirect_to exercise_path(@exercise), notice: "Exercise added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to root_path, notice: "Exercise updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @exercise.destroy
      redirect_to :home, notice: "Exercise deleted successfully"
    else
      render partial: 'shared/error', notice: "Deletion wasnt successful"
    end
  end

  def import
    @errors= Exercise.import(params[:file])
    if @errors.blank?
      redirect_to root_path, notice: "Import Successful"
    else 
      render 'import', notice: "Import wasnt Successful"
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :description, :category, :link, diets_attributes: [:id, :name, :_destroy])
  end

  def set_exercise
    @exercise= Exercise.find_by(id: params[:id])

    unless @exercise
      render partial: 'shared/error'
    end
  end

  def filtering_params
    params.slice(:filtering_params)
  end
end
