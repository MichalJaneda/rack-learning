module SharedContext
  module Action
    extend ::RSpec::SharedContext

    let(:url) { '' }
    let(:params) { {} }

    let(:action) { described_class.new }
    let(:request) { ::Rack::MockRequest.env_for(url, { params: params }) }

    let(:json_response) { JSON.parse(subject.body.first) }

    subject { action.call(request) }
  end
end
