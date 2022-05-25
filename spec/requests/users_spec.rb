require 'rails_helper'

RSpec.describe "Users", type: :request do
  # pending "add some examples (or delete) #{__FILE__}"
  let(:user){create(:user)}
  let(:admin_user){create(:user, role: :admin)}
  
  describe "GET /index" do
    before{sign_in admin_user}
    it 'renders the users index' do
      get users_path
      expect(response).to render_template('index')
    end

    it 'gives successful response' do
      get users_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    before{sign_in admin_user}
    it 'renders the show template' do 
      get user_url(id: user.id)
      expect(response).to render_template(:show)
    end

    it 'gives successful response' do
      get user_url(id: user.id)
      expect(response).to be_successful
    end

    context 'if the user does not exist' do
      it 'is not a success' do
        begin
          get user_url(-1)
        rescue
          ActiveRecord::RecordNotFound
        end
        expect(response).not_to render_template(:show)
      end
    end
  end

  let(:exercise1) {create(:exercise)}
  let(:exercise2) {create(:exercise)}
  let(:exercise3) {create(:exercise)}
  let(:exercise4) {create(:exercise)}

  describe "PATCH /manage_exercises" do
    before{sign_in admin_user}
    
    let(:exercise_ids) {[exercise1.id.to_s, exercise2.id.to_s, exercise3.id.to_s, exercise4.id.to_s]}
    it 'updates the exercises for the user' do
      user_exercise1= UserExercise.create(user_id: user.id, exercise_id: exercise1.id)
      expect(user.exercises.count).to eq(1)
      expect do
        patch manage_exercises_user_path(user), params: {"user" => {"exercise_ids" => exercise_ids }}
      end.to change(user.exercises, :count).by(3)
    end

    it "sends an email" do
      expect do 
        patch manage_exercises_user_path(user), params: {"user" => {"exercise_ids" => exercise_ids }}
      end.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe "GET /start_set" do
    before{sign_in user}
    it 'gives successful response' do
      get start_set_user_path(user.id)
      expect(response).to be_successful
    end
  end
end
