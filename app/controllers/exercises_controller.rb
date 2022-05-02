class ExercisesController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @exercises= current_user.exercises
  # end

  def show
    @exercise= Exercise.find(params[:id])
  end
end
