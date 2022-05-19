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
    CSV.foreach(file.path, headers:true) do |row|
      Exercise.create!(row.to_hash)
    end
  end

  def favourite?(user_id)
    user_exercises.find_by(user_id: user_id).favourite?
  end 

  def completed?(user_id)
    user_exercises.find_by(user_id: user_id).completed
  end
end
