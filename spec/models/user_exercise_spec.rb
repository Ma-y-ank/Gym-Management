require 'rails_helper'

RSpec.describe UserExercise, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'associations' do
    it {should belong_to(:user)}
    it {should belong_to(:exercise)}
  end
end
