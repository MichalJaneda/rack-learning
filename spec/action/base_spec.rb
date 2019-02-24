RSpec.describe Action::Base do
  it { expect { subject }.to raise_error(NotImplementedError) }

  context 'sequential requests' do
    let(:expected_response) { 'Appending!' }

    before do
      def action.handle
        response.write('Appending!')
      end
    end

    it 'does not increment Content-Length' do
      action.call(request)
      expect(subject.body).to contain_exactly(expected_response)
    end

    it 'does not increment Content-Length' do
      action.call(request)
      expect(subject.length).to eq(expected_response.length)
    end
  end

  context 'requiring authorization' do
    before do
      def action.handle
        authorize!
      end
    end

    it { expect(subject.status).to eq(403) }

    context 'authorization header present' do
      let!(:user) { create(:user) }

      let(:headers) { { Authorization: "Bearer #{token}"} }

      context 'mismatch' do
        let(:token) { '' }

        it { expect(subject.status).to eq(403) }
      end

      context 'is correct' do
        let(:token) { Digest::MD5.hexdigest(user.email) }

        it { expect { subject }.to_not raise_error }
      end
    end
  end
end
