FactoryBot.define do
  factory :notification do
    sequence(:title) { |i| "title-#{i}" }
    description { "desc" }
    user
  end
end
