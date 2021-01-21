FactoryBot.define do
  factory :user do
    name { "Test" }
    email  { "test@test.org" }
    password { "test" }
    password_confirmation { "test" }
  end

  factory :client, parent: :user, class: Client do
  end

  factory :admin, parent: :user, class: Admin do
  end
end