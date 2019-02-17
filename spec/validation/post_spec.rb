describe ValidationPost do
  subject { described_class.with(repository: Query::Repository::Post).(attributes) }

  it { is_expected.to be_failure }

  it { expect(errors).to eq(title: ['is missing'], body: ['is missing']) }

  context 'title and body set correctly' do
    let(:attributes) { { title: Faker::Lorem.word, body: Faker::Lorem.word } }

    it { is_expected.to be_success }
  end

  context 'title' do
    let(:attributes) { { title: title } }

    context 'filled correctly' do
      let(:title) { Faker::Lorem.word }

      it { is_expected.to be_failure }

      it { expect(errors).to_not have_key(:title) }
    end

    context 'too long' do
      let(:title) { 'x' * 257 }

      it { is_expected.to be_failure }

      it { expect(errors[:title]).to include('size cannot be greater than 256') }
    end

    context 'is taken' do
      let(:title) { 'Title' }

      before { Query::Repository::Post.insert(title: 'Title', body: Faker::Lorem.word) }

      it { is_expected.to be_failure }

      it { expect(errors[:title]).to include('is already taken') }
    end
  end

  context 'body' do
    let(:attributes) { { body: body } }

    context 'filled correctly' do
      let(:body) { Faker::Lorem.word }

      it { is_expected.to be_failure }

      it { expect(errors).to_not have_key(:body) }
    end
  end
end
