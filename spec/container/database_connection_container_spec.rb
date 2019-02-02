RSpec.describe DATABASE_CONNECTION_CONTAINER do
  describe '.resolve' do
    subject { described_class.resolve(item) }

    context 'connection' do
      let(:item) { 'connection' }

      it 'connection is immutable' do
        expect(subject.object_id)
          .to eq(described_class.resolve(item).object_id)
      end
    end
  end
end
