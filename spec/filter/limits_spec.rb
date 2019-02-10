RSpec.describe Filter::Limit do
  let(:default) { described_class::DEFAULT }

  let(:limit) { default }

  context 'empty params' do
    it { is_expected.to end_with("LIMIT #{default}") }
  end

  context 'params match' do
    let(:params) { { where: { limit: limit } } }

    context 'value' do
      context 'less than default' do
        let(:limit) { default - 1 }

        it { is_expected.to end_with("LIMIT #{limit}") }
      end

      context 'bigger than maximal' do
        let(:limit) { ::Value::Filter::Limit::MAX + 1 }

        it { is_expected.to end_with("LIMIT #{default}") }
      end

      context 'less than maximal' do
        let(:limit) { ::Value::Filter::Limit::MAX - 1 }

        it { is_expected.to end_with("LIMIT #{limit}") }
      end

      context 'non-positive' do
        let(:limit) { 0 }

        it { is_expected.to end_with("LIMIT #{default}") }
      end

      context 'is not integer' do
        let(:limit) { 0.1 }

        it { is_expected.to end_with("LIMIT #{default}") }
      end
    end
  end
end
