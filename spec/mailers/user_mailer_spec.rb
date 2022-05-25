require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) {create(:user)}
  let(:exercise1) {create(:exercise)}
  let(:exercise2) {create(:exercise)}
  let(:exercise3) {create(:exercise)}
  let(:exercise4) {create(:exercise)}
  let(:exercise_ids) {[exercise1.id.to_s, exercise2.id.to_s, exercise3.id.to_s, exercise4.id.to_s]}

  let(:mail) { described_class.with(:email => user.email, :exercises => exercise_ids).user_exercise_update.deliver_now }

  it 'renders the subject' do
    expect(mail.subject).to eq('Change in Workout Schedule')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['gym_admin@gmail.com'])
  end
end
