FactoryBot.define do
  factory :post, class: Model::Post do
    title { Faker::Lorem.unique.words.join('-') }
    body { Faker::Lorem.sentence }
    views { 0 }

    author { user.email }

    to_create(&:save)
  end
end
