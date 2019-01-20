module SharedContext
  module Action
    extend ::RSpec::SharedContext

    let(:action) { described_class.new }
    let(:request) { ::Rack::MockRequest.env_for }
  end
end
