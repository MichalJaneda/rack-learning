RSpec.describe Action::Post::Create do
  context 'unauthorized' do
    it { expect(subject.status).to eq(403) }
  end

  context 'authorized' do
    let(:user) { create(:user) }

    let(:headers) { { Authorization: "Bearer #{user.token}"} }

    context 'params' do
      context 'invalid' do
        it { expect(subject.status).to eq(422) }
      end

      context 'valid' do
        let(:params) { { title: Faker::Lorem.word, body: Faker::Lorem.word } }

        it { expect(subject.status).to eq(201) }

        it { expect { subject }.to change { Model::Post.count }.by(1) }
      end
    end
  end
end
