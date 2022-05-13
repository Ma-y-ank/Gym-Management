class Exercise < ApplicationRecord
  enum category: {Back: "Back", Leg: "Leg", Chest: "Chest", Arm: "Arm", Abs: "Abs", Shoulder: "Shoulder"}
  scope :by_category, ->(category) { where(category: category) }
  
  has_many :user_exercises
  has_many :users, through: :user_exercises

  has_many :diets, dependent: :destroy
  accepts_nested_attributes_for :diets, allow_destroy: true

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      Exercise.create!(row.to_hash)
    end
  end

  def favourite?(user_id)
    user_exercises.find_by(user_id: user_id).favourite?
  end 

  def status?(user_id)
    user_exercises.find_by(user_id: user_id).status
  end
end
