RSpec.describe Query::Repository::Users do
  describe '#with_comments' do
    subject { described_class.with_posts }

    let!(:user_without_posts) { Query::Repository::Users.insert(email: Faker::Internet.email, name: Faker::Name.name) }
    let!(:user_with_posts) { Query::Repository::Users.insert(email: Faker::Internet.email, name: Faker::Name.name) }

    before { Query::Repository::Posts.insert(author: user_with_posts, title: Faker::Lorem.word, body: Faker::Lorem.sentence) }

    it 'returns users with posts' do
      expect(subject.where(Sequel.lit('users.email = :email', email: user_with_posts)).count)
        .to eq(1)
    end

    it 'return users without posts' do
      expect(subject.where(Sequel.lit('users.email = :email', email: user_without_posts)).count)
        .to eq(1)
    end
  end
end
