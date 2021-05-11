require 'rails_helper'

describe User, type: :model do
  context 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  context 'validations' do
    before { create(:user) }
    context 'presence' do
      it { should validate_presence_of :first_name }
      it { should validate_presence_of :last_name }
      it { should validate_presence_of :email }
      it { should validate_presence_of :gender }
      it { should validate_presence_of :address }
      it { should validate_presence_of :profile_image }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end
  end

  context 'Invalid user' do
    let(:user) { create(:user) }
    it 'has a invalid user without first_name' do
      user.first_name = nil
      expect(user).to be_invalid
    end
    it 'has a invalid user without last_name' do
      user.last_name = nil
      expect(user).to be_invalid
    end
  end

  context 'associations' do
    it { should have_many(:todos).class_name('Todo') }
  end
end
