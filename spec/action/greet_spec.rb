RSpec.describe Action::Greet do
  it { expect(subject.body).to contain_exactly('Hello!') }
end
