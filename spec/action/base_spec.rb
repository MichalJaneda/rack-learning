RSpec.describe Action::Base do
  subject { described_class.new.call(env) }

  it { expect { subject }.to raise_error { NotImplementedError } }
end
