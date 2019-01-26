module SharedContext
  module Validation
    extend RSpec::SharedContext

    let(:attributes) { {} }
    let(:errors) { subject.errors }

    subject { described_class.(attributes) }
  end
end
