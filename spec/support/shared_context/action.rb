module SharedContext
  module Action
    extend ::RSpec::SharedContext

    let(:action) { described_class.new }
  end
end
