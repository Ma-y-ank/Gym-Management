class Exercise < ApplicationRecord
  enum category: {back: "Back", leg: "Leg", chest: "Chest", arm: "Arm", abs: "Abs", shoulder: "Shoulder"}
  
  validates :name, :description, :link, :category, presence: true
  validates :name, uniqueness: true

  scope :filter_by_category, ->(category) { where(category: category) }
  scope :filter_by_favourite, ->(user_id) {joins(:user_exercises).where(user_exercises:{favourite: true, user_id: user_id})}
  
  has_many :user_exercises
  has_many :users, through: :user_exercises
  
  has_many :diets, inverse_of: :exercise, dependent: :destroy
  accepts_nested_attributes_for :diets, allow_destroy: true

  def self.import(file)
    error=[]
    error_indexes= []
    CSV.foreach(file.path, headers:true).with_index do |row, index|
      exercise= Exercise.new(row.to_hash)
      unless exercise.valid?
        error << "There's a problem with row number #{index + 1}"
        error_indexes << index
      end
    end
    Resque.enque(AddNewExercisesJob, file, error_indexes)
    error
  end

  def favourite?(user_id)
    user_exercises.find_by(user_id: user_id).favourite?
  end 

  def completed?(user_id)
    user_exercises.find_by(user_id: user_id).completed
  end
end
