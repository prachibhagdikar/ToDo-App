FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { '12345678' }
    first_name { 'jsjd' }
    last_name { 'dsds' }
    gender { :male }
    address { 'SDasd' }
    profile_image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/images/avatar.jpg", 'image/jpg') }
  end

  factory :todo do
    name { 'To buy groceries' }
    categories { %w[home medical] }
    date { Date.new(2021, 5, 15) }
    is_done { false }
    reminder { true }
    reminder_date { Date.new(2001, 5, 14) }
    user
  end
end
