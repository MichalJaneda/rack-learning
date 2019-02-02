RSpec.describe Serializer::Base do
  let(:record) { { field_1: 1, field_2: '1' } }

  describe '#to_h' do
    subject { described_class.new(record).to_h }

    it { is_expected.to eq({}) }

    context 'attributes specified' do
      class AttributesSpecified < Serializer::Base
        ATTRIBUTES = { field_1: {}, field_2: {} }
      end

      subject { AttributesSpecified.new(record).to_h }

      it { is_expected.to eq({ field_1: 1, field_2: '1' }) }

      context 'attribute non default type' do
        class AttributesNonDefaultType < Serializer::Base
          ATTRIBUTES = { field_1: {}, field_2: ::Integer }
        end

        subject { AttributesNonDefaultType.new(record).to_h }

        it { is_expected.to eq({ field_1: 1, field_2: 1 }) }
      end

      context 'field missing' do
        let(:record) { { field_1: 1 } }

        it { is_expected.to eq({ field_1: 1 }) }
      end
    end
  end
end
