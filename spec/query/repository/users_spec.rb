RSpec.describe Query::Repository::User do
  describe '#with_comments' do
    subject { described_class.with_posts }

    let!(:user_without_posts) { Query::Repository::User.insert(email: Faker::Internet.email, name: Faker::Name.name) }
    let!(:user_with_posts) { Query::Repository::User.insert(email: Faker::Internet.email, name: Faker::Name.name) }

    before { Query::Repository::Post.insert(author: user_with_posts, title: Faker::Lorem.word, body: Faker::Lorem.sentence) }

    it 'returns users with posts' do
      expect(subject.where(Sequel.lit('users.email = :email', email: user_with_posts)).count)
        .to eq(1)
    end

    it 'return users without posts' do
      expect(subject.where(Sequel.lit('users.email = :email', email: user_without_posts)).count)
        .to eq(1)
    end
  end

  describe '#with_posts_having_views_over' do
    let!(:author) { Query::Repository::User.insert(email: Faker::Internet.email, name: Faker::Name.name) }
    let!(:popular_post) { Query::Repository::Post.insert(author: author, title: Faker::Lorem.word, body: Faker::Lorem.sentence, views: views) }
    let!(:not_popular_post) { Query::Repository::Post.insert(author: author, title: Faker::Lorem.word, body: Faker::Lorem.sentence) }

    let(:views) { 0 }

    subject { described_class.with_posts_having_views_over(views).all.first.posts.map(&:title) }

    it { is_expected.to contain_exactly(popular_post, not_popular_post) }

    context 'high views' do
      let(:views) { 10 }

      it { is_expected.to contain_exactly(popular_post) }
    end
  end

  describe '#having_popular_posts' do
    let!(:popular_post_author) { Query::Repository::User.insert(email: Faker::Internet.email, name: Faker::Name.name) }
    let!(:not_popular_post_author) { Query::Repository::User.insert(email: Faker::Internet.email, name: Faker::Name.name) }

    before do
      Query::Repository::Post.insert(author: popular_post_author, title: Faker::Lorem.word, body: Faker::Lorem.sentence, views: 10)
      Query::Repository::Post.insert(author: not_popular_post_author, title: Faker::Lorem.word, body: Faker::Lorem.sentence)
    end

    let(:views) { 0 }

    subject { described_class.having_popular_posts(views).map(&:email) }

    it { is_expected.to contain_exactly(not_popular_post_author, popular_post_author) }

    context 'high views' do
      let(:views) { 10 }

      it { is_expected.to contain_exactly(popular_post_author) }
    end
  end
end
