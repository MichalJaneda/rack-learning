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
end
