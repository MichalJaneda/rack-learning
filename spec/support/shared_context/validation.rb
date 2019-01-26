module SharedContext
  module Validation
    extend RSpec::SharedContext

    let(:attributes) { {} }

    subject { described_class.(attributes) }
  end
end
