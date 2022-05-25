class AddNewExercisesJob < ApplicationJob
  queue_as :default

  def perform(file, error_indexes)
    # Do something later
    # puts 'Hi this is testing'
    data= SmarterCSV.process(file)
    data.each_with_index do |hash, index|
      next if error_indexes.include?(index)
      Exercise.create(hash)
    end
  end
end
