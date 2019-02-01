module SharedContext
  module Action
    extend ::RSpec::SharedContext

    let(:url) { '' }
    let(:params) { {} }

    let(:action) { described_class.new }
    let(:request) { ::Rack::MockRequest.env_for(url, { params: params }) }

    subject { action.call(request) }
  end
end
