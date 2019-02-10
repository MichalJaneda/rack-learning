module SharedContext
  module Filter
    extend RSpec::SharedContext

    let!(:query) { Sequel.mock.dataset.from(:test).extension(:sequel_4_dataset_methods) }

    let(:params) { { where: {} } }
    let(:default) { nil }
    let(:check) { ->() { true } }

    subject { described_class.new(query, params[:where], default: default, check: check).call.sql }
  end
end
