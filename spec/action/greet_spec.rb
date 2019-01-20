RSpec.describe Action::Greet do
  describe '#call' do
    subject { action.call(request) }

    it { expect(subject.body).to contain_exactly('Hello!') }
  end
end
