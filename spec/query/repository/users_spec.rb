RSpec.describe Query::Repository::User do
  describe '#with_comments' do
    subject { described_class.with_posts }

    let!(:user_without_posts) { create(:user) }
    let!(:user_with_posts) { create(:user) }

    before { create(:post, author: user_with_posts.email) }

    it 'returns users with posts' do
      expect(subject.where(Sequel.lit('users.email = :email', email: user_with_posts.email)).count)
        .to eq(1)
    end

    it 'return users without posts' do
      expect(subject.where(Sequel.lit('users.email = :email', email: user_without_posts.email)).count)
        .to eq(1)
    end
  end

  describe '#with_posts_having_views_over' do
    let!(:author) { create(:user) }
    let!(:popular_post) { create(:post, author: author.email, views: views) }
    let!(:not_popular_post) { create(:post, author: author.email) }

    let(:views) { 0 }

    subject { described_class.with_posts_having_views_over(views).all.first.posts }

    it { is_expected.to contain_exactly(popular_post, not_popular_post) }

    context 'high views' do
      let(:views) { 10 }

      it { is_expected.to contain_exactly(popular_post) }
    end
  end

  describe '#having_popular_posts' do
    let!(:popular_post_author) { create(:user) }
    let!(:not_popular_post_author) { create(:user) }

    before do
      create(:post, author: popular_post_author.email, views: 10)
      create(:post, author: not_popular_post_author.email)
    end

    let(:views) { 0 }

    subject { described_class.having_popular_posts(views) }

    it { is_expected.to contain_exactly(not_popular_post_author, popular_post_author) }

    context 'high views' do
      let(:views) { 10 }

      it { is_expected.to contain_exactly(popular_post_author) }
    end
  end
end
