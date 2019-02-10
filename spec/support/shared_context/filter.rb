module SharedContext
  module Filter
    extend RSpec::SharedContext

    let!(:query) { Sequel.mock.dataset.from(:test).extension(:sequel_4_dataset_methods) }

    let(:params) { { where: {} } }

    subject { described_class.new(query, params[:where]).call.sql }
  end
end
