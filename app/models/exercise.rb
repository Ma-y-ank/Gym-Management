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
    errors= []
    # Check if the file is submitted or not
    return ['Please submit a file'] if file.blank?

    # Check if the format is CSV or not
    return ['Please check the format of the file.'] if File.extname(file) != '.csv'
    # file.path.split('.').last.to_s.downcase != 'csv'

    # Check if the headers are valid
    expected_headers= ['name', 'description', 'category', 'link']
    header= CSV.read(file.path, headers: true).headers
    header_check= header.all? {|header| expected_headers.include?(header.strip.downcase)} && header.count == expected_headers.count
    return ['Please check the headers of the file'] unless header_check

    data= SmarterCSV.process(file)
    data.each_with_index do |hash, index|
      exercise= Exercise.find_by(name: hash[:name].strip)
      exercise.update(hash) if exercise
      if exercise.previous_changes.present?
        next
      else
        begin
          Exercise.create!(hash)
        rescue => e
          errors << e.message + " for row #{index + 1}"
        end
      end
    end
    errors ? errors : nil
  end

  def favourite?(user_id)
    user_exercises.find_by(user_id: user_id).favourite?
  end 

  def completed?(user_id)
    user_exercises.find_by(user_id: user_id).completed
  end
end
