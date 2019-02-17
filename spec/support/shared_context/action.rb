module SharedContext
  module Action
    extend ::RSpec::SharedContext

    let(:url) { '' }
    let(:params) { {} }
    let(:headers) { {} }

    let(:action) { described_class.new }
    let(:request) do
      ::Rack::MockRequest.env_for(url, { params: params })
        .merge(headers.map { |header, value| ["HTTP_#{header.upcase}", value] }.to_h)
    end

    let(:json_response) { JSON.parse(subject.body.first) }

    subject { action.call(request) }
  end
end
