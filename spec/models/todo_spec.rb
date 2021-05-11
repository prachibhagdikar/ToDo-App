require 'rails_helper'

describe Todo, type: :model do
  context 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:todo)).to be_valid
    end
  end

  context 'validations' do
    before { create(:todo) }
    context 'presence' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :date }
    end
  end

  context 'Invalid todo' do
    let(:todo) { create(:todo) }
    it 'has a invalid todo without name' do
      todo.name = nil
      expect(todo).to be_invalid
    end
    it 'has a invalid todo without date' do
      todo.date = nil
      expect(todo).to be_invalid
    end
  end

  context 'associations' do
    it { should belong_to(:user).class_name('User') }
  end
end
