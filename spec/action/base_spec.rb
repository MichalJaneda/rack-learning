RSpec.describe Action::Base do
  describe '#call' do
    subject { action.call }

    it { expect { subject }.to raise_error { NotImplementedError } }
  end
end
