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
end
