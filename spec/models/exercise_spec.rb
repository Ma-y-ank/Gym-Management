require 'rails_helper'

RSpec.describe Exercise, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject(:exercise) { create(:exercise) }
  describe 'enum' do
    it {should define_enum_for(:category).backed_by_column_of_type(:string)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:category)}
    it {should validate_presence_of(:link)}
    it {should validate_uniqueness_of(:name)}
  end

  describe 'associations' do
    it {should have_many(:user_exercises)}
    it {should have_many(:users).through(:user_exercises)}
    it {should have_many(:diets).dependent(:destroy).inverse_of(:exercise)}
    it { should accept_nested_attributes_for(:diets)}
  end

  let(:user) {create(:user)}
  describe 'scope' do
    let(:exercise1) {create(:exercise)}
    let(:exercise2) {create(:exercise, category: 'Abs')}    

    it 'should filter by category' do
      expect(Exercise.filter_by_category('Back')).to include(exercise1)
      expect(Exercise.filter_by_category('Back')).not_to include(exercise2)
    end
    
    it 'should filter by favourite' do
      expect(Exercise.filter_by_favourite(user.id).count).to eq(0)
      @user_exercise= UserExercise.create(user_id: user.id, exercise_id: exercise2.id)
      @user_exercise.update(favourite: true)
      expect(Exercise.filter_by_favourite(user.id).count).to eq(1)
    end
  end

  describe 'instance methods' do
    it 'should check if a exercise is favourite?' do
      user_exercise= UserExercise.create(user_id: user.id, exercise_id: exercise.id)
      expect(exercise.favourite?(user.id)).to be false
      user_exercise.update(favourite: true)
      user_exercise.reload
      expect(exercise.favourite?(user.id)).to be true
    end

    it 'should check if a exercise is completed?' do 
      user_exercise= UserExercise.create(user_id: user.id, exercise_id: exercise.id)
      expect(exercise.completed?(user.id)).to be false
      user_exercise.update(completed: true)
      user_exercise.reload
      expect(exercise.completed?(user.id)).to be true
    end

    context "import a csv" do
      it 'should not import a empty file' do
        error= Exercise.import(nil)
        expect(error.count).to eq(1)
      end

      it 'should import a csv file' do
        error= Exercise.import("foo.txt")
        expect(error.count).to eq(1)
      end
    end
  end
end
