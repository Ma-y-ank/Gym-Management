require 'rails_helper'

RSpec.describe Diet, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'associations' do
    it {should belong_to(:exercise)}
  end 

  describe 'validations' do
    it {should validate_presence_of(:name)}
  end
end
