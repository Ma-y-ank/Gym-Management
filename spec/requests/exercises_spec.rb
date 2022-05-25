require 'rails_helper'

RSpec.describe "Exercises", type: :request do
  let(:user){create(:user)}
  let(:admin_user){create(:user, role: :admin)}
  
  let(:exercise) {create(:exercise)}
  let(:valid_attributes) do
    {
      'name' => 'Test',
      'description' => 'test',
      'category' => 'Back',
      'link' => 'https://www.youtube.com/watch?v=AAqPc0j_2bg'
    }
  end
  let(:invalid_attributes) do
    {
      'name' => '1',
      'description' => '1234',
      'category' => 'Shoulder',
      'link' => ''
    }
  end

  describe "GET /index" do
    # pending "add some examples (or delete) #{__FILE__}"
    before{sign_in user}
    it 'renders the exercises index' do
      get exercises_path
      expect(response).to render_template('index')
    end

    it 'gives successfull response' do
      get exercises_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    before{sign_in user}
    it 'renders the show template' do 
      get exercise_url(id: exercise.id)
      expect(response).to render_template(:show)
    end

    it 'gives successfull response' do
      get exercise_url(id: exercise.id)
      expect(response).to be_successful
    end

    context 'if the exercise does not exist' do
      it 'is not a success' do
        begin
          get exercise_url(-1)
        rescue
          ActiveRecord::RecordNotFound
        end
        expect(response).not_to render_template(:show)
      end
    end
  end

  describe 'GET /new' do
    before{sign_in admin_user}
    it 'renders a new exercise response' do
      get '/exercises/new'
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    before{sign_in admin_user}
    it 'renders a edit exercise response' do
      get edit_exercise_path(exercise)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    before{sign_in admin_user}
    context 'with valid parameters' do
      it 'creates a new Exercise' do
        expect do
          post '/exercises', params: { exercise: valid_attributes }
        end.to change(Exercise, :count).by(1)
      end

      it 'redirects to the created Exercise' do
        post exercises_path, params: { exercise: valid_attributes }
        expect(response).to redirect_to exercise_path(Exercise.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Exercise' do
        expect do
          post exercises_url, params: { exercise: invalid_attributes }
        end.to change(Exercise, :count).by(0)
      end

      it "renders the new template" do
        post exercises_url, params: { exercise: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /update' do
    before{sign_in admin_user}
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          'name' => 'Test',
          'description' => '12345',
          'category' => 'Back',
          'link' => 'https://www.youtube.com/watch?v=AAqPc0j_2ag'
        }
      end

      it 'updates the requested Exercise' do
        patch exercise_url(exercise), params: { exercise: new_attributes }
      end

      it 'redirects to the homepage' do
        patch exercise_url(exercise), params: { exercise: new_attributes }
        expect(response).to redirect_to('/')
      end
    end

    context 'with invalid parameters' do
      it "renders the edit template" do
        patch exercise_url(exercise), params: { exercise: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /destroy' do
    before{sign_in admin_user}
    before {exercise}
    it 'destroys the requested exercise' do
      expect do
        delete exercise_url(exercise)
      end.to change(Exercise, :count).by(-1)
    end
    it 'redirects to the homepage' do
      delete exercise_url(exercise)
      expect(response).to redirect_to('/home')
    end
  end

  describe 'PATCH /change_status' do
    before{sign_in user}
    before(:all) do 
      @exercise1= create(:exercise)
      @exercise2= create(:exercise)
    end
    
    it 'change the exercise status' do
      @user_exercise1= UserExercise.create(user_id: user.id, exercise_id: @exercise1.id)
      @user_exercise2= UserExercise.create(user_id: user.id, exercise_id: @exercise2.id) 
      expect(@user_exercise1.completed).to be false
      patch change_status_exercise_path(@exercise1), xhr: true
      @user_exercise1.reload
      expect(@user_exercise1.completed).to be true
    end
  end

  describe 'PATCH /toggle_favourite' do
    before{sign_in user}
    before(:all) do 
      @exercise1= create(:exercise)
      @exercise2= create(:exercise)
    end

    it 'toggle exercise to favourite' do
      @user_exercise1= UserExercise.create(user_id: user.id, exercise_id: @exercise1.id)
      @user_exercise2= UserExercise.create(user_id: user.id, exercise_id: @exercise2.id)
      btn_text = @exercise1.favourite?(user.id) ? "Unfavourite" : "Favourite" 
      patch toggle_favourite_exercise_path(@exercise1),params: {type: btn_text}, xhr: true
      expect(@user_exercise1.favourite).to be false
      @user_exercise1.reload
      expect(@user_exercise1.favourite).to be true
    end
  end

  describe 'POST /import' do
    before{sign_in admin_user}
    
    it 'imports the exercise file' do
      expect(Exercise).to receive(:import).with("foo.txt")
      post import_exercises_path, params: {file: "foo.txt"}
    end 

    it 'received invalid file' do
      post import_exercises_path, params: {file: "foo.txt"}
      expect(response).to render_template('import')
    end
  end
end
