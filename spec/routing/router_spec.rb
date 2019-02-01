RSpec.describe Routing::Router do
  describe '.routing' do
    let!(:router) { described_class.routing }

    let(:klass) { nil }
    let(:method) { 'GET' }
    let(:path) { '/' }

    subject { router.recognize(path, method: method.downcase.to_sym ) }

    shared_examples_for 'routes correctly' do
      it { expect(subject.verb).to eq(method) }

      it { is_expected.to be_routable }

      it 'recognizes action class' do
        expected_action = Hanami::Utils::String.transform(klass,:underscore).gsub('/', '_')
        target_action = subject.action.gsub(/[#|_]/, '_')
        expect(target_action)
          .to eq(expected_action),
              "Expected #{method} #{path} to route to #{expected_action}, got #{target_action} instead"

      end
    end

    describe 'GET /' do
      let(:klass) { Action::Greet }

      it_behaves_like 'routes correctly'
    end

    describe 'GET ' do
      let(:klass) { Action::Greet }
      let(:path) { '/greet' }

      it_behaves_like 'routes correctly'
    end

    describe 'POST /users' do
      let(:klass) { Action::User::Create }
      let(:path) { '/user' }
      let(:method) { 'POST' }

      it_behaves_like 'routes correctly'
    end
  end
end
