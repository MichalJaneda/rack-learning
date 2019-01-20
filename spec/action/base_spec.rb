RSpec.describe Action::Base do
  describe '#call' do
    subject { action.call(request) }

    it { expect { subject }.to raise_error(NotImplementedError) }
  end
end
