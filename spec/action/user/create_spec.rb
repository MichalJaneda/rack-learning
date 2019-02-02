RSpec.describe Action::User::Create do
  shared_examples_for 'user creation failed' do
    it { expect(subject.status).to eq(422) }

    it 'does not create new user' do
      expect { subject }
        .to_not change { Query::Repository::Users.count }
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

      it 'created new user' do
        subject
        expect(Query::Repository::Users.where(email: params[:email]))
          .to_not be_empty
      end

      context 'user email already taken' do
        before {  Query::Repository::Users.insert(email: params[:email], name: 'John Doe') }

        it_behaves_like 'user creation failed'
      end
    end
  end
end
