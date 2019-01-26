describe ValidationUserCreate do
  it { is_expected.to be_failure }

  it { expect(errors).to eq(email: ['is missing'], name: ['is missing']) }

  context 'name' do
    let(:attributes) { { name: name } }

    context 'filled correctly' do
      let(:name) { 'John Doe' }

      it { is_expected.to be_failure }

      it { expect(errors).to_not have_key(:name) }
    end

    context 'too long' do
      let(:name) { 'x' * 257 }

      it { is_expected.to be_failure }

      it { expect(errors[:name]).to include('size cannot be greater than 256') }
    end
  end

  context 'email' do
    let(:attributes) { { email: email } }

    context 'filled correctly' do
      let(:email) { 'user@example.com' }

      it { is_expected.to be_failure }

      it { expect(errors).to_not have_key(:email) }
    end

    context 'in invalid format' do
      let(:email) { 'wrong_format@@example.com' }

      it { is_expected.to be_failure }

      it { expect(errors[:email]).to include('is in invalid format') }
    end

    context 'not unique' do

    end
  end

  context 'email and name set correctly' do
    let(:attributes) { { name: 'John Doe', email: 'user@example.com' } }

    xit { is_expected.to be_success }
  end
end
