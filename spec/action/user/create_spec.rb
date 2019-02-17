RSpec.describe Action::User::Create do
  shared_examples_for 'user creation failed' do
    it { expect(subject.status).to eq(422) }

    it 'does not create new user' do
      expect { subject }
        .to_not change { Query::Repository::User.count }
    end
  end

  context 'params' do
    let(:params) { {} }

    context 'missing' do
      it_behaves_like 'user creation failed'
    end

    context 'are correct' do
      let(:params) { { name: 'John', email: 'user@example.com' } }

      it { expect(subject.status).to eq(201) }

      it 'creates new user' do
        subject
        expect(Query::Repository::User.where(email: params[:email]))
          .to_not be_empty
      end

      it 'attaches token' do
        subject
        expect(Query::Repository::User.find(email: params[:email]).token)
          .to eq(Digest::MD5.hexdigest(params[:email]))
      end

      context 'user email already taken' do
        before { Query::Repository::User.insert(email: params[:email], name: 'John Doe', token: Digest::MD5.hexdigest(params[:email])) }

        it_behaves_like 'user creation failed'
      end
    end
  end
end
