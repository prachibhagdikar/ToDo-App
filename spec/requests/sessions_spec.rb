require 'rails_helper'

RSpec.describe 'Sessions' do
  let(:user) {create :user}
  it 'signs user in and out' do
    user.save
    sign_in user
    get profile_path
    expect(controller.current_user).to eq(user)

    sign_out user
    get root_path
    expect(controller.current_user).to be_nil
  end

end