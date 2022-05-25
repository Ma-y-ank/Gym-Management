require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  describe "associations" do 
    it {should belong_to(:trainer).optional}
    it {should have_many(:trainees)}
    it {should have_many(:user_exercises)}
    it {should have_many(:exercises).through(:user_exercises)}
    it {should have_many(:diets).through(:exercises)}
  end

  describe "enum" do
    it { should define_enum_for(:role).backed_by_column_of_type(:string)}
  end

  describe "instance methods" do
    subject(:user){create(:user)}
    
    let(:exercise1){create(:exercise)}
    let(:exercise2){create(:exercise)}
    let(:exercise3){create(:exercise)}
    
    it 'should return current day exercises' do
      @user_exercise1= UserExercise.create(user_id: user.id, exercise_id: exercise1.id)
      @user_exercise2= UserExercise.create(user_id: user.id, exercise_id: exercise2.id)
      expect(user.current_day_exercises.count).to eq(2)
    end

    it 'should return completed exercises count' do
      @user_exercise1= UserExercise.create(user_id: user.id, exercise_id: exercise1.id)
      @user_exercise2= UserExercise.create(user_id: user.id, exercise_id: exercise2.id)
      expect(user.completed_exercises_count).to eq(0)
      @user_exercise1.update(completed: true)
      expect(user.completed_exercises_count).to eq(1)
    end
  end
end
