RSpec.describe Action::User::Create do
  shared_examples_for 'user creation failed' do
    it { expect(subject.status).to eq(422) }

    it 'does not create new user' do
      expect { subject }
        .to_not change { Model::User.count }
    end
  end

  context 'params' do
    let(:params) { {} }

    context 'missing' do
      it_behaves_like 'user creation failed'
    end

    context 'are correct' do
      let(:params) { attributes_for(:user).slice(:name, :email) }

      it { expect(subject.status).to eq(201) }

      it 'creates new user' do
        subject
        expect(Model::User.find(email: params[:email]))
          .to be_instance_of(Model::User)
      end

      it 'attaches token' do
        subject
        expect(Model::User.find(email: params[:email]).token)
          .to eq(Digest::MD5.hexdigest(params[:email]))
      end

      context 'user email already taken' do
        before { create(:user, email: params[:email]) }

        it_behaves_like 'user creation failed'
      end
    end
  end
end
