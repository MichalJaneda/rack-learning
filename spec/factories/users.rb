FactoryBot.define do
  factory :user, class: Model::User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    token { Digest::MD5.hexdigest(email) }

    to_create(&:save)
  end
end
