RSpec.describe Operation::Post::Create do
  let(:user) { nil }
  let(:params) { {} }

  subject { described_class.(params, current_user: user) }

  it { is_expected.to be_failure }

  context 'validation failure' do
    it { is_expected.to be_failure }
  end

  context 'validation success' do
    let(:params) { { title: Faker::Lorem.word, body: Faker::Lorem.word } }

    context 'no author set' do
      it { is_expected.to be_failure }
    end

    context 'author set' do
      let(:user) do
        Model::User.find(email: Query::Repository::User.insert(email: Faker::Internet.email,
                                                               name: Faker::Internet.name,
                                                               token: ''))
      end

      it { is_expected.to be_success }

      it { expect { subject }.to change { Model::Post.count }.by(1) }

      it { expect(subject['model']).to be_instance_of(::Model::Post) }
    end
  end
end
