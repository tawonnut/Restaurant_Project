FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :user do
    email
    name "ชาริล"
    surname "ชับบอม"
    tel "0894788962"
    password "marsbom1234"
    password_confirmation "marsbom1234"
  end
end
